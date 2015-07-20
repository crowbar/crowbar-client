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

            c.desc "Filter output by criteria"
            c.flag [:filter], type: String, default_value: nil

            c.action do |global, opts, args|
              Request.instance.barclamp_list do |request|
                case request.code
                when 200
                  body = begin
                    JSON.parse(request.body)
                  rescue
                    []
                  end

                  # TODO(must): Implement filter method
                  case opts[:format].to_sym
                  when :table
                    rows = body.keys.map do |name|
                      [name]
                    end

                    if rows.empty?
                      err "No barclamps"
                    else
                      say Terminal::Table.new(
                        rows:     rows.sort,
                        headings: [
                          "Name"
                        ]
                      )
                    end
                  when :json
                    rows = [].tap do |result|
                      body.keys.each do |name|
                        result.push(
                          name: name
                        )
                      end
                    end

                    if rows.empty?
                      err "No barclamps"
                    else
                      say JSON.pretty_generate(
                        rows.sort_by { |r| r[:name] }
                      )
                    end
                  else
                    err "Invalid format, valid formats: table, json"
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
