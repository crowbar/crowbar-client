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
        # Implementation for the proposal edit command
        #
        class Edit < Base
          include Mixin::Barclamp
          include Mixin::Proposal

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
              if options[:raw]
                result.parsed_response
              else
                deployment_cleanup result.parsed_response
              end
            when 404
              err "Failed to preload proposal"
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

            # check if the nodes in the configuration are in the list of nodes
            check_nodes(json)

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

            # check if the nodes in the configuration are in the list of nodes
            check_nodes(json)

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
            result = editor.result

            # check if the nodes in the configuration are in the list of nodes
            check_nodes(result)

            result
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
            else
              from_editor
            end
          end

          def check_nodes(configuration)
            invalid_nodes = []
            nodes_and_clusters = valid_elements

            configuration["deployment"].each do |service_name, service|
              next if service["elements"].nil?

              service["elements"].each do |role, nodes|
                nodes.each do |node|
                  unless nodes_and_clusters.include?(node)
                    invalid_nodes << { "node" => node, "role" => role,
                                       "service_name" => service_name }
                  end
                end
              end
            end

            return if invalid_nodes.empty?

            error_str = ""

            invalid_nodes.each do |error|
              error_str += "ERROR : #{error["node"]} is not available in the list of" \
              " possible nodes and clusters. Added in role #{error["role"]}" \
              " of service #{error["service_name"]}\r\n"
            end

            err error_str
          end
        end
      end
    end
  end
end
