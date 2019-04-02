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
    module App
      #
      # A Thor based CLI wrapper for SES commands
      #
      class Ses < Base
        desc "upload FILE",
          "Upload SES configuration file"

        long_desc <<-LONGDESC
          `upload FILE` will upload yaml file with SES configuration to the
          server. Data inside this file could be used later for integrating
          SES cluster with other services.
        LONGDESC

        #
        # SES config upload command
        #
        # It will upload yaml file with SES configuration to the server.
        # Data inside this file could be used later for integrating SES
        # cluster with other services.
        #
        # @param file [String] the path to the file
        #
        def upload(file)
          Command::Ses::Upload.new(
            *command_params(
              file: file
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
