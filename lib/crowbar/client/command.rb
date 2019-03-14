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
    #
    # Module for the command implementations
    #
    module Command
      autoload :Backup,
        File.expand_path("../command/backup", __FILE__)

      autoload :Barclamp,
        File.expand_path("../command/barclamp", __FILE__)

      autoload :Base,
        File.expand_path("../command/base", __FILE__)

      autoload :Batch,
        File.expand_path("../command/batch", __FILE__)

      autoload :Database,
        File.expand_path("../command/database", __FILE__)

      autoload :HostIP,
        File.expand_path("../command/host_ip", __FILE__)

      autoload :Installer,
        File.expand_path("../command/installer", __FILE__)

      autoload :Interface,
        File.expand_path("../command/interface", __FILE__)

      autoload :Node,
        File.expand_path("../command/node", __FILE__)

      autoload :Proposal,
        File.expand_path("../command/proposal", __FILE__)

      autoload :Repository,
        File.expand_path("../command/repository", __FILE__)

      autoload :Role,
        File.expand_path("../command/role", __FILE__)

      autoload :Ses,
        File.expand_path("../command/ses", __FILE__)

      autoload :Server,
        File.expand_path("../command/server", __FILE__)

      autoload :Upgrade,
        File.expand_path("../command/upgrade", __FILE__)

      autoload :VirtualIP,
        File.expand_path("../command/virtual_ip", __FILE__)

      autoload :Services,
        File.expand_path("../command/services", __FILE__)
    end
  end
end
