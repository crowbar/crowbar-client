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
      class HostIp < Base
        desc "allocate PROPOSAL NODE NETWORK RANGE [SUGGESTION]",
          "Allocate a host IP address"

        long_desc <<-LONGDESC
          `allocate PROPOSAL NODE NETWORK RANGE [SUGGESTION]` will
          try to allocate a host IP address for the specified node.
        LONGDESC

        def allocate(proposal, node, network, range, suggestion = nil)
          Command::VirtualIp::Allocate.new(
            *command_params(
              proposal: proposal,
              node: node,
              network: network,
              range: range,
              suggestion: suggestion
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "deallocate PROPOSAL NODE NETWORK",
          "Deallocate a host IP address"

        long_desc <<-LONGDESC
          `deallocate PROPOSAL NODE NETWORK` will try to deallocate
          a host IP address for the specified node.
        LONGDESC

        def deallocate(proposal, node, network)
          Command::VirtualIp::Allocate.new(
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
