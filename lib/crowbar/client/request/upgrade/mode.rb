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

require "easy_diff"

module Crowbar
  module Client
    module Request
      module Upgrade
        #
        # Implementation for the upgrade mode request
        #
        class Mode < Base
          #
          # Override the request headers
          #
          # @return [Hash] the headers for the request
          #
          def headers
            super.easy_merge!(
              ::Crowbar::Client::Util::ApiVersion.new(2.0).headers
            )
          end

          #
          # Override the request content
          #
          # @return [Hash] the content for the request
          #
          def content
            super.easy_merge!(
              mode: attrs.mode
            )
          end

          #
          # HTTP method that gets used by the request
          #
          # @return [Symbol] the method for the request
          #
          def method
            if attrs.mode
              :post
            else
              :get
            end
          end

          #
          # Path to the API endpoint for the request
          #
          # @return [String] path to the API endpoint
          #
          def url
            [
              "api",
              "upgrade",
              "mode"
            ].join("/")
          end
        end
      end
    end
  end
end
