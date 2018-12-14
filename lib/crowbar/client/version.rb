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
    # A representation of the current Crowbar CLI version
    #
    class Version
      #
      # Major version
      #
      MAJOR = 3

      #
      # Minor version
      #
      MINOR = 7

      #
      # Patch version
      #
      PATCH = 0

      #
      # Optional suffix
      #
      PRE = nil

      class << self
        #
        # Convert the Crowbar CLI version to a string
        #
        # @return [String] the version of Crowbar CLI
        #
        def to_s
          [MAJOR, MINOR, PATCH, PRE].compact.join(".")
        end
      end
    end
  end
end
