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
      module Proposal
        extend ActiveSupport::Concern

        included do
          desc "Proposal specific commands"
          command "proposal" do |parent|
            parent.desc "Show a list of available proposals"
            parent.arg :barclamp
            parent.command "list" do |c|
              c.desc "Format of the resulting output"
              c.flag [:format], type: String, default_value: :table

              c.desc "Filter output by criteria"
              c.flag [:filter], type: String, default_value: nil

              c.action do |global, opts, args|
                barclamp = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_list(barclamp) do |request|
                  case request.code
                  when 200
                    formatter = Formatter::Array.new(
                      format: opts[:format],
                      headings: ["Proposals"],
                      values: Filter::Array.new(
                        filter: opts[:filter],
                        values: request.parsed_response.sort
                      ).result
                    )

                    if formatter.empty?
                      exit_now! "No proposals"
                    else
                      say formatter.result
                    end
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Show a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.arg :path, :optional
            parent.command "show" do |c|
              c.desc "Format of the resulting output"
              c.flag [:format], type: String, default_value: :table

              c.desc "Filter output by criteria"
              c.flag [:filter], type: String, default_value: nil

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_show(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    formatter = Formatter::Hash.new(
                      format: opts[:format],
                      path: opts[:filter],
                      headings: ["Key", "Value"],
                      values: Filter::Subset.new(
                        filter: opts[:filter],
                        values: request.parsed_response
                      ).result
                    )

                    if formatter.empty?
                      exit_now! "No result"
                    else
                      say formatter.result
                    end
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Create a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command "create" do |c|
              c.desc "Proposal data in json format"
              c.flag [:data], type: String, default_value: nil

              c.desc "Proposal data as a json file"
              c.flag [:file], type: String, default_value: nil

              c.desc "Merge input with proposal data"
              c.switch [:merge], negatable: false

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                template = Request.instance.proposal_template(
                  barclamp
                ).parsed_response.easy_merge(
                  "id" => proposal
                )

                case
                when opts[:data]
                  json = begin
                    JSON.load opts[:data]
                  rescue
                    exit_now! "Invalid json data"
                  end

                  payload = if opts[:merge]
                    template.easy_merge json
                  else
                    json
                  end
                when opts[:file]
                  json = begin
                    JSON.load opts[:file]
                  rescue
                    exit_now! "Invalid json file"
                  end

                  payload = if opts[:merge]
                    template.easy_merge json
                  else
                    json
                  end
                else
                  begin
                    editor = Util::Editor.new content: template
                    editor.edit!

                    payload = editor.result
                  rescue EditorAbortError => e
                    exit_now! e.message
                  rescue EditorStartupError => e
                    exit_now! e.message
                  rescue InvalidJsonError => e
                    exit_now! e.message
                  rescue
                    exit_now! "Editing content failed"
                  end
                end

                Request.instance.proposal_create(barclamp, proposal, payload) do |request|
                  case request.code
                  when 200
                    say "Created successfully #{proposal} on #{barclamp}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Edit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command "edit" do |c|
              c.desc "Proposal data in json format"
              c.flag [:data], type: String, default_value: nil

              c.desc "Proposal data as a json file"
              c.flag [:file], type: String, default_value: nil

              c.desc "Merge input with proposal data"
              c.switch [:merge], negatable: false

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                original = Request.instance.proposal_show(
                  barclamp,
                  proposal
                ).parsed_response

                case
                when opts[:data]
                  json = begin
                    JSON.load opts[:data]
                  rescue
                    exit_now! "Invalid json data"
                  end

                  payload = if opts[:merge]
                    original.easy_merge json
                  else
                    json
                  end
                when opts[:file]
                  json = begin
                    JSON.load opts[:file]
                  rescue
                    exit_now! "Invalid json file"
                  end

                  payload = if opts[:merge]
                    original.easy_merge json
                  else
                    json
                  end
                else
                  begin
                    editor = Util::Editor.new content: original
                    editor.edit!

                    payload = editor.result
                  rescue EditorAbortError => e
                    exit_now! e.message
                  rescue EditorStartupError => e
                    exit_now! e.message
                  rescue InvalidJsonError => e
                    exit_now! e.message
                  rescue
                    exit_now! "Editing content failed"
                  end
                end

                Request.instance.proposal_update(barclamp, proposal, payload) do |request|
                  case request.code
                  when 200
                    say "Updated successfully #{proposal} on #{barclamp}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Delete a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command "delete" do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_delete(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Deleted successfully #{proposal} on #{barclamp}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Dequeue a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command "dequeue" do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_dequeue(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Dequeued successfully #{proposal} on #{barclamp}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Commit a proposal for specific barclamp"
            parent.arg :barclamp
            parent.arg :proposal
            parent.command "commit" do |c|
              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_commit(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    say "Commited successfully #{proposal} on #{barclamp}"
                  when 202
                    say "Queued #{proposal} on #{barclamp}"
                  else
                    exit_now! request.parsed_response["error"]
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
