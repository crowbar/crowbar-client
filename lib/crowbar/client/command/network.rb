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
      module Network
        extend ActiveSupport::Concern

        included do
          desc "Network specific commands"
          command :network do |parent|
            parent.desc "Actions for virtual IP addresses"
            parent.command :virtual do |c|
              c.desc "Allocate virtual IP address"
              c.arg :name
              c.arg :service
              c.arg :network
              c.arg :range
              c.arg :suggestion, :optional
              c.command :allocate do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  service = args.shift
                  network = args.shift
                  range = args.shift
                  suggestion = args.shift || ""

                  Request.instance.network_allocate_virtual(
                    name,
                    service,
                    network,
                    range,
                    suggestion
                  ) do |request|
                    case request.code
                    when 200
                      say JSON.pretty_generate(request.parsed_response)
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end

              c.desc "Deallocate virtual IP address"
              c.arg :name
              c.arg :service
              c.arg :network
              c.command :deallocate do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  service = args.shift
                  network = args.shift

                  Request.instance.network_deallocate_virtual(
                    name,
                    service,
                    network
                  ) do |request|
                    case request.code
                    when 200
                      say "Successfully deallocated the IP"
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end
            end

            parent.desc "Actions for real IP addresses"
            parent.command :ip do |c|
              c.desc "Allocate real IP address"
              c.arg :name
              c.arg :node
              c.arg :network
              c.arg :range
              c.arg :suggestion, :optional
              c.command :allocate do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  node = args.shift
                  network = args.shift
                  range = args.shift
                  suggestion = args.shift || ""

                  Request.instance.network_allocate_ip(
                    name,
                    node,
                    network,
                    range,
                    suggestion
                  ) do |request|
                    case request.code
                    when 200
                      say JSON.pretty_generate(request.parsed_response)
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end

              c.desc "Deallocate real IP address"
              c.arg :name
              c.arg :node
              c.arg :network
              c.command :deallocate do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  node = args.shift
                  network = args.shift

                  Request.instance.network_deallocate_ip(
                    name,
                    node,
                    network
                  ) do |request|
                    case request.code
                    when 200
                      say "Successfully deallocated the IP"
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end
            end

            parent.desc "Actions for network interfaces"
            parent.command :interface do |c|
              c.desc "Enable a network interface"
              c.arg :name
              c.arg :node
              c.arg :network
              c.command :enable do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  node = args.shift
                  network = args.shift

                  Request.instance.network_enable_interface(
                    name,
                    node,
                    network
                  ) do |request|
                    case request.code
                    when 200
                      say JSON.pretty_generate(request.parsed_response)
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end

              c.desc "Disable a network interface"
              c.arg :name
              c.arg :node
              c.arg :network
              c.command :disable do |a|
                a.action do |_global, _opts, args|
                  name = args.shift
                  node = args.shift
                  network = args.shift

                  Request.instance.network_disable_interface(
                    name,
                    node,
                    network
                  ) do |request|
                    case request.code
                    when 200
                      say "Successfully disabled the interface"
                    else
                      exit_now! request.parsed_response["error"]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
