#
# Copyright 2015, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "json"
require "easy_diff"

module Crowbar
  module Client
    module Command
      module Proposal
        class Edit < Base
          include Mixin::Barclamp

          def request
            @request ||= Request::Proposal::Edit.new(
              args.easy_merge(
                payload: payload_content
              )
            )
          end

          def execute
            validate_barclamp! args.barclamp

            request.process do |request|
              case request.code
              when 200
                say "Successfully updated #{args.proposal} proposal"
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def proposal_preload
            result = Request::Proposal::Show.new(
              barclamp: args.barclamp,
              proposal: args.proposal
            ).process

            case result.code
            when 200
              result.parsed_response
            when 404
              err "Failed to preload proposal"
            else
              err result.parsed_response["error"]
            end
          end

          def from_data
            json = begin
              JSON.load options.data
            rescue
              err "Invalid json data"
            end

            if options.merge
              proposal_preload.easy_merge(
                json
              )
            else
              json
            end
          end

          def from_file
            json = begin
              JSON.load options.file
            rescue
              err "Invalid json file"
            end

            if options.merge
              proposal_preload.easy_merge(
                json
              )
            else
              json
            end
          end

          def from_editor
            editor = Util::Editor.new content: proposal_preload
            editor.edit!

            editor.result
          rescue EditorAbortError => e
            err e.message
          rescue EditorStartupError => e
            err e.message
          rescue InvalidJsonError => e
            err e.message
          rescue SimpleCatchableError => e
            err e.message
          rescue
            err "Editing content failed"
          end

          def payload_content
            case
            when options.data
              from_data
            when options.file
              from_file
            else
              from_editor
            end
          end
        end
      end
    end
  end
end
