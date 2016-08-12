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
      #
      # Base that provides methods shared between request implementations
      #
      class Base
        attr_accessor :request
        attr_accessor :attrs

        def initialize(attrs = {})
          self.attrs = Hashie::Mash.new(attrs)
        end

        def request
          @request ||= Rest.new(url: url)
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
          case method
          when :post
            [
              method,
              content
            ]
          when :put
            [
              method,
              content.to_json
            ]
          else
            [
              method
            ]
          end
        end

        def process
          result = begin
            request.send(
              *params,
              accept: headers["Accept"],
              content_type: headers["Content-Type"]
            )
          rescue => e
            if e.class.superclass == RestClient::RequestFailed
              Hashie::Mash.new(
                parsed_response: {
                  error: e.message
                },
                code: e.http_code
              )
            else
              raise e
            end
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
