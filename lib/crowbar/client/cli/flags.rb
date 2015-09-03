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
    class Cli
      module Flags
        extend ActiveSupport::Concern

        included do
          desc "Path to a configuration file"
          flag [:c, :config], default_value: nil

          desc "Alias for a config section"
          flag [:a, :alias], default_value: "default"

          desc "Specify username for connection"
          flag [:U, :username], default_value: "crowbar"

          desc "Specify password for connection"
          flag [:P, :password], default_value: "crowbar"

          desc "Specify host for connection"
          flag [:n, :hostname], default_value: "http://127.0.0.1"

          desc "Specify port for connection"
          flag [:p, :port], default_value: "80"

          desc "Specify timeout for connection"
          flag [:t, :timeout], default_value: "60"

          desc "Output debug informations"
          switch [:d, :debug], negatable: false

          desc "Call legacy routes for 1.x compatibility"
          switch [:l, :legacy], negatable: false
        end
      end
    end
  end
end
