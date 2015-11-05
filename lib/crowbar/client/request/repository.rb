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
    module Request
      module Repository
        autoload :Activate,
          File.expand_path("../repository/activate", __FILE__)

        autoload :ActivateAll,
          File.expand_path("../repository/activate_all", __FILE__)

        autoload :Deactivate,
          File.expand_path("../repository/deactivate", __FILE__)

        autoload :DeactivateAll,
          File.expand_path("../repository/deactivate_all", __FILE__)

        autoload :List,
          File.expand_path("../repository/list", __FILE__)
      end
    end
  end
end
