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
    module App
      class Interface < Base
        desc "enable PROPOSAL NODE NETWORK",
          "Enable a network interface"

        long_desc <<-LONGDESC
          `enable PROPOSAL NODE NETWORK` will try to enable the
          specified network interface on the specified node.
        LONGDESC

        def enable(proposal, node, network)
          Command::Interface::Enable.new(
            *command_params(
              proposal: proposal,
              node: node,
              network: network
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "disable PROPOSAL NODE NETWORK",
          "Disable a network interface"

        long_desc <<-LONGDESC
          `disable PROPOSAL NODE NETWORK` will try to disable the
          specified network interface on the specified node.
        LONGDESC

        def disable(proposal, node, network)
          Command::Interface::Disable.new(
            *command_params(
              proposal: proposal,
              node: node,
              network: network
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end
      end
    end
  end
end
