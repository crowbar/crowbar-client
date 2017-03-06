#
# Copyright 2017, SUSE Linux GmbH
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
        # Implementation for the upgrade nodes command
        #
        class Mode < Base
          include Mixin::UpgradeError

          def request
            @request ||= Request::Upgrade::Mode.new(
              args
            )
          end

          def execute
            unless ["normal", "non_disruptive", nil].include? args.mode
              err "Invalid upgrade mode '#{args.mode}'. " \
                  "Only 'normal' and 'non_disruptive' are valid upgrade modes"
            end

            method = request.method
            request.process do |request|
              case request.code
              when 200
                if method == :post
                  say "Successfully switched to the \"#{args.mode}\" upgrade mode. "
                else
                  mode = request.parsed_response["mode"] || "none"
                  say "Selected upgrade mode: '#{mode}'"
                end
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
