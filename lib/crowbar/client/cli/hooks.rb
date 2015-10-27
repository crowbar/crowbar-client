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
      module Hooks
        extend ActiveSupport::Concern

        included do
          pre do |global|
            ENV["GLI_DEBUG"] = "true" if global[:debug]

            config = configure(global[:config], global[:alias])

            Request.instance.configure(
              host:     config[:hostname] || global[:hostname],
              port:     config[:port] || global[:port],
              username: config[:username] || global[:username],
              password: config[:password] || global[:password],
              legacy:   config[:legacy] || global[:legacy],
              debug:    config[:debug] || global[:debug],
              timeout:  config[:timeout] || global[:timeout]
            )

            true
          end
        end
      end
    end
  end
end
