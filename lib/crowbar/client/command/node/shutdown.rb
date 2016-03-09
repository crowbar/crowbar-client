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

require "easy_diff"

module Crowbar
  module Client
    module Command
      module Node
        class Shutdown < Base
          def request
            @request ||= Request::Node::Shutdown.new(
              args.easy_merge(
                action: :shutdown
              )
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                say "Successfully triggered shutdown for #{args.name}"
              when 404
                err "Node does not exist"
              else
                err request.parsed_response["error"]
              end
            end
          end
        end
      end
    end
  end
end
