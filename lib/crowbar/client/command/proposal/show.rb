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
      module Proposal
        #
        # Implementation for the proposal show command
        #
        class Show < Base
          include Mixin::Barclamp
          include Mixin::Proposal

          include Mixin::Format
          include Mixin::Filter

          def request
            @request ||= Request::Proposal::Show.new(
              args
            )
          end

          def execute
            validate_barclamp! args.barclamp

            request.process do |request|
              case request.code
              when 200
                content = if options[:raw]
                  content_from(request)
                else
                  deployment_cleanup(content_from(request))
                end

                formatter = Formatter::Nested.new(
                  format: provide_format,
                  path: provide_filter,
                  headings: ["Key", "Value"],
                  values: Filter::Subset.new(
                    filter: provide_filter,
                    values: content
                  ).result
                )

                if formatter.empty?
                  err "No result"
                else
                  say formatter.result
                end
              when 404
                err "Proposal does not exist"
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
