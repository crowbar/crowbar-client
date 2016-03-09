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
      module Backup
        #
        # Implementation for the backup list command
        #
        class List < Base
          include Mixin::Format
          include Mixin::Filter

          def request
            @request ||= Request::Backup::List.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                formatter = Formatter::Hash.new(
                  format: provide_format,
                  headings: headings,
                  values: Filter::Hash.new(
                    filter: provide_filter,
                    values: content_from(request)
                  ).result
                )

                if formatter.empty?
                  err "No backups"
                else
                  say formatter.result
                end
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def headings
            ["Name", "Created", "Size", "Version"]
          end

          def content_from(request)
            request.parsed_response.map do |row|
              row.slice(
                "name",
                "created_at",
                "size",
                "version"
              ).tap do |values|
                values["size"] = number_to_human_size(
                  values["size"]
                )
              end
            end
          end
        end
      end
    end
  end
end
