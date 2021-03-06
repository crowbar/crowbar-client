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
    module Command
      module Server
        #
        # Implementation for the server API command
        #
        class Api < Base
          include Mixin::Barclamp

          def request
            @request ||= Request::Server::Api.new(
              args
            )
          end

          def execute
            validate_barclamp! args.barclamp

            request.process do |request|
              case request.code
              when 200
                say JSON.pretty_generate(
                  content_from(request)
                )
              else
                err request.parsed_response["error"]
              end
            end
          end

          protected

          def content_from(request)
            request.parsed_response
          end
        end
      end
    end
  end
end
