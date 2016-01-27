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
        class Download < Base
          def request
            @request ||= Request::Backup::Download.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                if write(request.body)
                  say "Successfully downloaded backup"
                else
                  err "Failed to download backup"
                end
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def write(body)
            path.binmode
            path.write body

            true
          rescue
            false
          end

          def path
            @path ||=
              case args.file
              when "-"
                stdout.to_io
              when File
                args.file
              else
                backup = Request::Backup::List.new.process do |p|
                  p.parsed_response.detect do |row|
                    row["id"] == args.id.to_i
                  end
                end

                File.new(
                  args.file || "#{backup["name"]}.tar.gz"
                )
              end
          end
        end
      end
    end
  end
end
