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

require "httparty"

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
                  say "Successfully downloaded backup to #{path}"
                else
                  say "Failed to download backup to #{path}"
                end
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def write(body)
            path.open("wb") do |f|
              f.binmode
              f.write body

              true
            end
          rescue
            false
          end

          def path
            Pathname.new("#{args.name}-#{args.created_at}.tar.gz")
          end
        end
      end
    end
  end
end
