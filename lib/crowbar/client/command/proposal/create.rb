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
        #
        # Implementation for the proposal create command
        #
        class Create < Base
          include Mixin::Barclamp

          def request
            @request ||= Request::Proposal::Create.new(
              args.easy_merge!(
                payload: payload_content.to_hash
              )
            )
          end

          def execute
            validate_barclamp! args.barclamp

            request.process do |request|
              case request.code
              when 200
                say "Successfully created #{args.proposal} proposal"
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def proposal_preload
            result = Request::Proposal::Template.new(
              barclamp: args.barclamp
            ).process

            case result.code
            when 200
              result.parsed_response.easy_merge(
                "id" => args.proposal
              )
            when 404
              err "Failed to preload template"
            else
              err result.parsed_response["error"]
            end
          end

          def from_data
            json = begin
              JSON.load(
                options[:data]
              )
            rescue JSON::ParserError
              err "Failed to parse JSON"
            end

            if json["id"] != args.proposal
              json["id"] = args.proposal
              say "Using id(#{json["id"]}) as proposal name"
            end

            if options[:merge]
              proposal_preload.easy_merge(
                json
              )
            else
              json
            end
          end

          def from_file
            json = begin
              file = File.read(
                options[:file]
              )

              JSON.load(
                file
              )
            rescue Errno::EACCES
              err "Failed to access file"
            rescue Errno::ENOENT
              err "Failed to read file"
            rescue JSON::ParserError
              err "Failed to parse JSON"
            rescue
              err "Failed to process file"
            end

            if json["id"] != args.proposal
              json["id"] = args.proposal
              say "Using id(#{json["id"]}) as proposal name"
            end

            if options[:merge]
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
            when options[:data]
              from_data
            when options[:file]
              from_file
            when options[:default]
              proposal_preload
            else
              from_editor
            end
          end
        end
      end
    end
  end
end
