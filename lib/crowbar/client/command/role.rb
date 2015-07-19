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
      module Role
        extend ActiveSupport::Concern

        included do
          desc "Role specific commands for barclamps"
          command :role do |parent|
            parent.desc "Show a list of available roles"
            parent.arg :barclamp
            parent.command :list do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                helper.validate_availability_of! barclamp

                $request.role_list(barclamp) do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body)
                    rescue
                      []
                    end

                    if body.empty?
                      err "No roles"
                    else
                      say body.sort.join("\n")
                    end
                  when 404
                    err "Barclamp does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Show details of a specific role"
            parent.arg :barclamp
            parent.arg :role
            parent.command :show do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                role = args.shift
                helper.validate_availability_of! barclamp

                $request.role_show(barclamp, role) do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body)
                    rescue
                      []
                    end

                    if body.empty?
                      err "No nodes"
                    else
                      say body.sort.join("\n")
                    end
                  when 404
                    err "Role does not exist"
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
end
