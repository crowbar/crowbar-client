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

          case result.code
          when 500
            raise InternalServerError,
              "An internal error occured"
          when 401
            raise NotAuthorizedError,
              "User is not authorized"
          when 403
            raise NotAuthorizedError,
              "User access is forbidden"
          end

          if block_given?
            yield result
          else
            result
          end
        end
      end
    end
  end
end
