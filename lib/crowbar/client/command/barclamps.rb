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
      module Barclamps
        extend ActiveSupport::Concern

        included do
          desc "List all available barclamps"
          command :barclamps do |c|
            c.desc "Format of the resulting output"
            c.flag [:format], type: String, default_value: :table

            c.action do |global, opts, args|
              $request.barclamp_list do |request|
                case request.code
                when 200
                  body = begin
                    JSON.parse(request.body).keys
                  rescue
                    []
                  end

                  if body.empty?
                    err "No barclamps"
                  else
                    say body.sort.join("\n")
                  end
                else
                  err "Got unknown response with code #{request.code}"
                end
              end
            end
          end
        end
      end
    end
  end
end
