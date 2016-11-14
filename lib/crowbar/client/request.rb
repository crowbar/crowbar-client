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
    # Module for the available request implementations
    #
    module Request
      autoload :Backup,
        File.expand_path("../request/backup", __FILE__)

      autoload :Barclamp,
        File.expand_path("../request/barclamp", __FILE__)

      autoload :Base,
        File.expand_path("../request/base", __FILE__)

      autoload :Batch,
        File.expand_path("../request/batch", __FILE__)

      autoload :Database,
        File.expand_path("../request/database", __FILE__)

      autoload :HostIP,
        File.expand_path("../request/host_ip", __FILE__)

      autoload :Installer,
        File.expand_path("../request/installer", __FILE__)

      autoload :Interface,
        File.expand_path("../request/interface", __FILE__)

      autoload :Node,
        File.expand_path("../request/node", __FILE__)

      autoload :Proposal,
        File.expand_path("../request/proposal", __FILE__)

      autoload :Repository,
        File.expand_path("../request/repository", __FILE__)

      autoload :Rest,
        File.expand_path("../request/rest", __FILE__)

      autoload :Role,
        File.expand_path("../request/role", __FILE__)

      autoload :Server,
        File.expand_path("../request/server", __FILE__)

      autoload :Upgrade,
        File.expand_path("../request/upgrade", __FILE__)

      autoload :VirtualIP,
        File.expand_path("../request/virtual_ip", __FILE__)
    end
  end
end
