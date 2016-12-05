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
      module Upgrade
        #
        # Implementation for the upgrade backup command
        #
        class Backup < Base
          include Mixin::UpgradeError

          def request
            @request ||= Request::Upgrade::Backup.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                say "Successfully created backup for #{args.component}"
              else
                case args.component
                when "crowbar"
                  err format_error(
                    request.parsed_response["error"], "admin_backup"
                  )
                when "openstack"
                  err format_error(
                    request.parsed_response["error"], "nodes_db_dump"
                  )
                else
                  request.parsed_response["error"]
                end
              end
            end
          end
        end
      end
    end
  end
end
