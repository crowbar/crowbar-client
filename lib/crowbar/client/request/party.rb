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

require "httmultiparty"

module Crowbar
  module Client
    module Request
      #
      # Client for executing the HTTP API requests
      #
      class Party
        include HTTMultiParty

        follow_redirects true
        format :json

        def initialize
          self.class.base_uri(
            config.server
          )

          self.class.default_timeout(
            config.timeout
          )

          self.class.digest_auth(
            config.username,
            config.password
          ) if should_auth

          self.class.debug_output(
            $stderr
          ) if should_debug
        end

        def config
          @config ||= Config
        end

        def method_missing(method, *arguments, &block)
          if self.class.respond_to?(method, true)
            self.class.send(method, *arguments, &block)
          else
            super
          end
        end

        def respond_to?(method_sym, include_private = false)
          if self.class.respond_to?(method, true)
            true
          else
            super
          end
        end

        protected

        def should_auth
          !config.anonymous
        end

        def should_debug
          config.debug
        end
      end
    end
  end
end
