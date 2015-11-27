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
      module Installer
        class Start < Base
          def request
            @request ||= Request::Installer::Start.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                say "Triggered Administration Server installation"
              when 226
                say "Crowbar already installing"
              when 410
                say "Installation is already done. If you want to reinstall to get a fresh \
setup, please remove the following file: /var/lib/crowbar/install/crowbar-installed-ok"
              when 501
                err "Installation on this platform is not supported"
              else
                err request.parsed_response["error"]
              end
            end
          end
        end
      end
    end
  end
end
