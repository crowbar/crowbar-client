#
# Copyright 2016, SUSE Linux GmbH
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

require "rest-client"

module Crowbar
  module Client
    module Request
      class Rest < RestClient::Resource
        def initialize(options = {})
          url = options.fetch(:url, "")
          user = options.fetch(:user, Config.username)
          password = options.fetch(:password, Config.password)
          auth_type = options.fetch(:auth_type, :digest)
          verify_ssl = options.fetch(:verify_ssl, Config.verify_ssl)

          Config.debug && RestClient.log = "stdout"

          super(
            [
              Config.server,
              "/",
              url
            ].join(""),
            user: URI::DEFAULT_PARSER.escape(user, URI::PATTERN::RESERVED),
            password: URI::DEFAULT_PARSER.escape(password, URI::PATTERN::RESERVED),
            auth_type: auth_type,
            verify_ssl: verify_ssl,
            timeout: Config.timeout
          )
        end
      end
    end
  end
end
