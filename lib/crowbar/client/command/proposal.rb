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
              c.action do |global, opts, args|
                barclamp = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_list(barclamp) do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body)
                    rescue
                      []
                    end

                    if body.empty?
                      err "No proposals"
                    else
                      say body.sort.join("\n")
                    end
                  when 404
                    err "Failed to find any available proposals"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Show a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.arg :path, :optional
            parent.command :show do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                path = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_show(barclamp, proposal) do |request|
                  body = begin
                    JSON.parse(request.body).with_indifferent_access
                  rescue
                    {}
                  end

                  case request.code
                  when 200
                    begin
                      path.to_s.split(".").each do |segment|
                        body = body[segment]
                      end

                      if body.is_a?(Hash) || body.is_a?(Array)
                        say JSON.pretty_generate(body)
                      else
                        say body
                      end
                    rescue
                      err "Path does not fully exist"
                    end
                  when 404
                    err "Proposal does not exist"
                  when 409
                    # TODO(must): Implement this return code in controller
                    err body[:errors].to_sentence
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
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end

            parent.desc "Edit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :edit do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                fail "Not implemented yet!"
              end
            end



            parent.desc "Delete a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :delete do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_delete(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Deleted successfully #{proposal} on #{barclamp}"
                  when 404
                    err "Proposal does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Dequeue a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :dequeue do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_action(:dequeue, barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Dequeued #{proposal} on #{barclamp}"
                  when 404
                    err "Proposal does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Commit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command :commit do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_action(:commit, barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Commited #{proposal} on #{barclamp}"
                  when 202
                    say "Queued #{proposal} on #{barclamp}"
                  when 404
                    err "Proposal does not exist"
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
