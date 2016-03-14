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
      # A Thor based CLI wrapper for virtual IP commands
      #
      class VirtualIP < Base
        namespace "network virtualip"

        desc "allocate PROPOSAL SERVICE NETWORK RANGE [SUGGESTION]",
          "Allocate a virtual IP address"

        long_desc <<-LONGDESC
          `allocate PROPOSAL SERVICE NETWORK RANGE [SUGGESTION]` will
          try to allocate a virtual IP address for the specified service.
        LONGDESC

        #
        # Virtual IP allocate command
        #
        # It will try to allocate a virtual IP address for the specified
        # service.
        #
        # @param proposal [String] the proposal name
        # @param service [String] the service name
        # @param network [String] the network name
        # @param range [String] the network range
        # @param suggestion [String] an optional suggestion
        #
        def allocate(proposal, service, network, range, suggestion = nil)
          Command::VirtualIP::Allocate.new(
            *command_params(
              proposal: proposal,
              service: service,
              network: network,
              range: range,
              suggestion: suggestion
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "deallocate PROPOSAL SERVICE NETWORK",
          "Deallocate a virtual IP address"

        long_desc <<-LONGDESC
          `deallocate PROPOSAL SERVICE NETWORK` will try to deallocate
          a virtual IP address for the specified service.
        LONGDESC

        #
        # Virtual IP deallocate command
        #
        # It will try to deallocate a virtual IP address.
        #
        # @param proposal [String] the proposal name
        # @param service [String] the service name
        # @param network [String] the network name
        #
        def deallocate(proposal, service, network)
          Command::VirtualIP::Deallocate.new(
            *command_params(
              proposal: proposal,
              service: service,
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
