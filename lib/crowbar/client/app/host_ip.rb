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
      #
      # A Thor based CLI wrapper for host IP commands
      #
      class HostIP < Base
        namespace "network hostip"

        desc "allocate PROPOSAL NODE NETWORK RANGE [SUGGESTION]",
          "Allocate a host IP address"

        long_desc <<-LONGDESC
          `allocate PROPOSAL NODE NETWORK RANGE [SUGGESTION]` will
          try to allocate a host IP address for the specified node.
        LONGDESC

        #
        # Host IP allocate command
        #
        # It will try to allocate a host IP address for the specified
        # node.
        #
        # @param proposal [String] the proposal name
        # @param node [String] the node name or alias
        # @param network [String] the network name
        # @param range [String] the network range
        # @param suggestion [String] an optional suggestion
        #
        def allocate(proposal, node, network, range, suggestion = nil)
          Command::HostIP::Allocate.new(
            *command_params(
              proposal: proposal,
              node: node,
              network: network,
              range: range,
              suggestion: suggestion
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "deallocate PROPOSAL NODE NETWORK",
          "Deallocate a host IP address"

        long_desc <<-LONGDESC
          `deallocate PROPOSAL NODE NETWORK` will try to deallocate
          a host IP address for the specified node.
        LONGDESC

        #
        # Host IP deallocate command
        #
        # It will try to deallocate a host IP address.
        #
        # @param proposal [String] the proposal name
        # @param node [String] the node name or alias
        # @param network [String] the network name
        #
        def deallocate(proposal, node, network)
          Command::HostIP::Deallocate.new(
            *command_params(
              proposal: proposal,
              node: node,
              network: network
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
