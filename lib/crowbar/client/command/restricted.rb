#
# Copyright 2019, SUSE
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
      #
      # Module for the Restricted command implementations
      #
      module Restricted
        autoload :Allocate,
          File.expand_path("../restricted/allocate", __FILE__)

        autoload :Ping,
          File.expand_path("../restricted/ping", __FILE__)

        autoload :Show,
          File.expand_path("../restricted/show", __FILE__)

        autoload :Transition,
          File.expand_path("../restricted/transition", __FILE__)
      end
    end
  end
end
