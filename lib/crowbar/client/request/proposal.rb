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
      module Proposal
        autoload :Commit,
          File.expand_path("../proposal/commit", __FILE__)

        autoload :Create,
          File.expand_path("../proposal/create", __FILE__)

        autoload :Delete,
          File.expand_path("../proposal/delete", __FILE__)

        autoload :Dequeue,
          File.expand_path("../proposal/dequeue", __FILE__)

        autoload :Edit,
          File.expand_path("../proposal/edit", __FILE__)

        autoload :List,
          File.expand_path("../proposal/list", __FILE__)

        autoload :Show,
          File.expand_path("../proposal/show", __FILE__)

        autoload :Template,
          File.expand_path("../proposal/template", __FILE__)
      end
    end
  end
end
