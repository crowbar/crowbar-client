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
    module Filter
      autoload :Array,
        File.expand_path("../filter/array", __FILE__)

      autoload :Base,
        File.expand_path("../filter/base", __FILE__)

      autoload :Hash,
        File.expand_path("../filter/hash", __FILE__)

      autoload :Subset,
        File.expand_path("../filter/subset", __FILE__)
    end
  end
end
