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

module Crowbar
  module Client
    module Command
      module Repository
        #
        # Implementation for the repository list command
        #
        class List < Base
          include Mixin::Format
          include Mixin::Filter

          def request
            @request ||= Request::Repository::List.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                formatter = Formatter::Hash.new(
                  format: provide_format,
                  headings: ["Platform", "Repo"],
                  values: Filter::Hash.new(
                    filter: provide_filter,
                    values: content_from(request)
                  ).result
                )

                if formatter.empty?
                  err "No repositories"
                else
                  say formatter.result
                end
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def content_from(request)
            [].tap do |row|
              request.parsed_response.each do |child|
                row.push(
                  platform: child["platform"],
                  repo: child["id"]
                )
              end
            end
          end
        end
      end
    end
  end
end
