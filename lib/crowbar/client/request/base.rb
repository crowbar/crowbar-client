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

require "hashie"

module Crowbar
  module Client
    module Request
      class Base
        attr_accessor :request
        attr_accessor :attrs

        def initialize(attrs = {})
          self.attrs = Hashie::Mash.new(attrs)
        end

        def request
          @request ||= Party.new
        end

        def content
          @content ||= {}
        end

        def headers
          @headers ||= {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        end

        def params
          {
            body: content.to_json,
            headers: headers
          }
        end

        def process
          result = request.send(
            method,
            [
              "/",
              url
            ].join(""),
            params
          )

          send(
            errors[result.code]
          ) if errors[result.code]

          if block_given?
            yield result
          else
            result
          end
        end

        def errors
          {
            401 => :not_authorized,
            403 => :not_authorized,
            500 => :internal_server,
            502 => :bad_gateway,
            503 => :service_unavailable,
            504 => :gateway_timeout
          }
        end

        def not_authorized
          raise NotAuthorizedError,
            "User is not authorized"
        end

        def internal_server
          raise InternalServerError,
            "An internal error occured"
        end

        def bad_gateway
          raise BadGatewayError,
            "Received a bad gateway error"
        end

        def service_unavailable
          raise ServiceUnavailableError,
            "Service is not available"
        end

        def gateway_timeout
          raise GatewayTimeoutError,
            "Received a gateway timeout"
        end
      end
    end
  end
end
