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
      module Node
        autoload :Action,
          File.expand_path("../node/action", __FILE__)

        autoload :Delete,
          File.expand_path("../node/delete", __FILE__)

        autoload :Group,
          File.expand_path("../node/group", __FILE__)

        autoload :List,
          File.expand_path("../node/list", __FILE__)

        autoload :Rename,
          File.expand_path("../node/rename", __FILE__)

        autoload :Role,
          File.expand_path("../node/role", __FILE__)

        autoload :Show,
          File.expand_path("../node/show", __FILE__)

        autoload :Status,
          File.expand_path("../node/status", __FILE__)

        autoload :Transition,
          File.expand_path("../node/transition", __FILE__)
      end
    end
  end
end
