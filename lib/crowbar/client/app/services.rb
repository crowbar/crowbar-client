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
    module App
      #
      # A Thor based CLI wrapper for Services commands
      #
      class Services < Base
        desc "list_restarts",
             "List services that require a restart"

        long_desc <<-LONGDESC
          `list_restarts` will print out a list of the services requiring restart.
          You can display the list in different output formats.
        LONGDESC

        def list_restarts
          Command::Services::ListServiceRestarts.new(*command_params).execute
        rescue => e
          catch_errors(e)
        end

        desc "clear_restart NODE [COOKBOOK [SERVICE]]",
             "Clear the restart flag for a service on a node"

        long_desc <<-LONGDESC
          `clear_restart NODE [COOKBOOK [SERVICE]]` will clear the 'restart needed' flag
          for the given SERVICE, or all services in a COOKBOOK, or all services on the NODE.
        LONGDESC
        def clear_restart(node, cookbook = nil, service = nil)
          Command::Services::ClearServiceRestart.new(
            *command_params(
              node: node,
              cookbook: cookbook,
              service: service
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "restart_flags",
             "List cookbooks and their restart status (allowed/disallowed)"

        def restart_flags
          Command::Services::ListRestartFlags.new(*command_params).execute
        rescue => e
          catch_errors(e)
        end

        desc "disable_restart COOKBOOK VALUE",
             "Set the restart disallowed for a cookbook to true/false"
        def disable_restart(cookbook, value)
          unless ["true", "false"].include? value.downcase
            msg = "#{value} is not a valid value for this command. Please use true or false"
            raise SimpleCatchableError(msg)
          end
          value = value.casecmp("true").zero? ? true : false
          Command::Services::SetRestartFlag.new(
            *command_params(
              cookbook: cookbook,
              disallow_restart: value
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
