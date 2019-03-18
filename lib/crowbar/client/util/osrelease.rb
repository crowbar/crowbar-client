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
    module Util
      class OsRelease
        class << self
          def fields
            os_release_file = "/etc/os-release"

            if File.exist?(os_release_file)
              return Hash[
                File.open(os_release_file).read.scan(/(\S+)\s*=\s*"([^"]+)/)
              ]
            end

            {}
          end
        end
      end
    end
  end
end
