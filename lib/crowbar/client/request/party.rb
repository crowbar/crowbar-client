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

require "httparty"
require "singleton"

module Crowbar
  module Client
    module Request
      class Party
        include Singleton
        include HTTParty

        follow_redirects true
        format :json

        def configure(options)
          self.class.base_uri options[:server]
          self.class.digest_auth options[:username], options[:password]
          self.class.default_timeout options[:timeout].to_i
          self.class.debug_output $stderr if options[:debug]
        end
      end
    end
  end
end
