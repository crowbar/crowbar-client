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
    class Request
      module Repository
        extend ActiveSupport::Concern

        included do
          def repository_list
            result = self.class.get(
              "/utils/repositories.json"
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def repository_activate(platform, repo)
            result = self.class.post(
              "/utils/repositories/activate.json",
              body: {
                platform: platform,
                repo: repo
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def repository_activate_all(platform, repo)
            result = self.class.post(
              "/utils/repositories/activate_all.json"
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def repository_deactivate(platform, repo)
            result = self.class.post(
              "/utils/repositories/deactivate.json",
              body: {
                platform: platform,
                repo: repo
              }
            )

            if block_given?
              yield result
            else
              result
            end
          end

          def repository_deactivate_all(platform, repo)
            result = self.class.post(
              "/utils/repositories/deactivate_all.json"
            )

            if block_given?
              yield result
            else
              result
            end
          end
        end
      end
    end
  end
end
