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

require "easy_diff"

module Crowbar
  module Client
    module Command
      module Batch
        class Export < Base
          def request
            args.easy_merge!(
              includes: options.includes,
              excludes: options.excludes
            )

            @request ||= Request::Batch::Export.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                if write(request.body)
                  say "Successfully exported batch"
                else
                  err "Failed to export batch"
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
            case args.file
            when "-"
              @path ||= stdout.to_io
            when File
              @path ||= args.file
            else
              @path ||= File.new(
                args.file
              )
            end
          end
        end
      end
    end
  end
end
