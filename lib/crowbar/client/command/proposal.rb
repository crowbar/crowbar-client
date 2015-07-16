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
        extend ActiveSupport::Concern

        included do
          desc "Proposal specific commands for barclamps"
          command :proposal do |parent|
            parent.desc "Show a list of available proposals"
            parent.arg :barclamp
            parent.command :list do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                helper.validate_availability_of! barclamp

                $request.proposal_list(barclamp) do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body)
                    rescue
                      []
                    end

                    say body.join("\n")
                  when 404
                    err "Failed to find any available proposal"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Create a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :create do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Show a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :show do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Edit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :edit do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Delete a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :delete do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Commit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :commit do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Dequeue a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :dequeue do |c|
              c.action do |_global, _opts, args|
                barclamp = args.shift
                # proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end
          end
        end
      end
    end
  end
end
