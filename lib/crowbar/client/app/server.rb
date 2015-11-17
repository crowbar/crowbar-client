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
    module App
      class Server < Base
        desc "api BARCLAMP",
          "Show the API documentation"

        long_desc <<-LONGDESC
          `api BARCLAMP` will print out the API documentation that is
          available for the specified barclamp.
        LONGDESC

        def api(barclamp)
          Command::Server::Api.new(
            *command_params(
              barclamp: barclamp
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end
      end
    end
  end
end
