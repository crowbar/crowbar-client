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
      class Network < Base
        desc "virtualip [COMMANDS]",
          "Actions for virtual IP addresses, call without params for help"
        subcommand "virtualip", Crowbar::Client::App::VirtualIP

        desc "hostip [COMMANDS]",
          "Actions for host IP addresses, call without params for help"
        subcommand "hostip", Crowbar::Client::App::HostIP

        desc "interface [COMMANDS]",
          "Actions for network interfaces, call without params for help"
        subcommand "interface", Crowbar::Client::App::Interface
      end
    end
  end
end
