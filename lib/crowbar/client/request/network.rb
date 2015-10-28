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
    class Request
      module Network
        extend ActiveSupport::Concern

        included do
          def network_allocate_virtual_ip(
            proposal,
            service,
            network,
            range,
            suggestion
          )
            result = self.class.post(
              "/crowbar/network/1.0/allocate_virtual_ip/#{proposal}.json",
              body: {
                name: service,
                network: network,
                range: range,
                suggestion: suggestion
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def network_deallocate_virtual_ip(
            proposal,
            service,
            network
          )
            result = self.class.post(
              "/crowbar/network/1.0/deallocate_virtual_ip/#{proposal}.json",
              body: {
                name: service,
                network: network
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def network_allocate_ip(
            proposal,
            node,
            network,
            range,
            suggestion
          )
            result = self.class.post(
              "/crowbar/network/1.0/allocate_ip/#{proposal}.json",
              body: {
                name: node,
                network: network,
                range: range,
                suggestion: suggestion
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def network_deallocate_ip(
            proposal,
            node,
            network
          )
            result = self.class.post(
              "/crowbar/network/1.0/deallocate_ip/#{proposal}.json",
              body: {
                name: node,
                network: network
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def network_enable_interface(
            proposal,
            node,
            network
          )
            result = self.class.post(
              "/crowbar/network/1.0/enable_interface/#{proposal}.json",
              body: {
                name: node,
                network: network
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def network_disable_interface(
            proposal,
            node,
            network
          )
            result = self.class.post(
              "/crowbar/network/1.0/disable_interface/#{proposal}.json",
              body: {
                name: node,
                network: network
              }.to_json,
              headers: {
                "Content-Type" => "application/json"
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end
        end
      end
    end
  end
end
