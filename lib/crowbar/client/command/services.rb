#
# Copyright 2017, SUSE Linux GmbH
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
      # Module for the List Restarts command implementations
      #
      module Services
        autoload :ListServiceRestarts, File.expand_path("../services/list_restarts", __FILE__)
        autoload :ClearServiceRestart, File.expand_path("../services/clear_restart", __FILE__)
        autoload :ListRestartFlags, File.expand_path("../services/restart_flags", __FILE__)
        autoload :SetRestartFlag, File.expand_path("../services/disable_restart", __FILE__)
      end
    end
  end
end
