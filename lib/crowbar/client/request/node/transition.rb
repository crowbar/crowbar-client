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

require "easy_diff"

module Crowbar
  module Client
    module Request
      module Node
        #
        # Implementation for the node transition request
        #
        class Transition < Base
          def content
            super.easy_merge!(
              name: attrs.name,
              state: attrs.state
            )
          end

          def method
            :post
          end

          def url
            [
              "crowbar",
              "crowbar",
              "1.0",
              "transition",
              "default"
            ].join("/")
          end
        end
      end
    end
  end
end
