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
      autoload :Barclamp,
        File.expand_path("../app/barclamp", __FILE__)

      autoload :Base,
        File.expand_path("../app/base", __FILE__)

      autoload :Batch,
        File.expand_path("../app/batch", __FILE__)

      autoload :Entry,
        File.expand_path("../app/entry", __FILE__)

      autoload :HostIP,
        File.expand_path("../app/host_ip", __FILE__)

      autoload :Installer,
        File.expand_path("../app/installer", __FILE__)

      autoload :Interface,
        File.expand_path("../app/interface", __FILE__)

      autoload :Network,
        File.expand_path("../app/network", __FILE__)

      autoload :Node,
        File.expand_path("../app/node", __FILE__)

      autoload :Proposal,
        File.expand_path("../app/proposal", __FILE__)

      autoload :Repository,
        File.expand_path("../app/repository", __FILE__)

      autoload :Reset,
        File.expand_path("../app/reset", __FILE__)

      autoload :Role,
        File.expand_path("../app/role", __FILE__)

      autoload :Server,
        File.expand_path("../app/server", __FILE__)

      autoload :VirtualIP,
        File.expand_path("../app/virtual_ip", __FILE__)
    end
  end
end
