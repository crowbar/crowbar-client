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
    module Command
      #
      # Module for the backup command implementations
      #
      module Backup
        autoload :Create,
          File.expand_path("../backup/create", __FILE__)

        autoload :Delete,
          File.expand_path("../backup/delete", __FILE__)

        autoload :Download,
          File.expand_path("../backup/download", __FILE__)

        autoload :List,
          File.expand_path("../backup/list", __FILE__)

        autoload :Restore,
          File.expand_path("../backup/restore", __FILE__)

        autoload :Upload,
          File.expand_path("../backup/upload", __FILE__)
      end
    end
  end
end
