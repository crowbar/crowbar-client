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
              c.desc <<-EOF
                Format of the output, valid formats are table, json or plain
              EOF

              c.flag [:format],
                type: String,
                default_value: :table,
                must_match: [:table, :json, :plain]

              c.desc <<-EOF
                Filter by criteria, display only data that contains filter
              EOF

              c.flag [:filter],
                type: String,
                default_value: nil

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
              c.desc <<-EOF
                Format of the output, valid formats are table, json or plain
              EOF

              c.flag [:format],
                type: String,
                default_value: :table,
                must_match: [:table, :json, :plain]

              c.desc <<-EOF
                Filter by criteria, display only data that contains filter
              EOF

              c.flag [:filter],
                type: String,
                default_value: nil

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                Request.instance.proposal_show(barclamp, proposal) do |request|
                  case request.code
                  when 200
                    formatter = Formatter::Nested.new(
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
              c.desc <<-EOF
                Reading proposal data from this json string
              EOF

              c.flag [:data],
                type: String,
                default_value: nil

              c.desc <<-EOF
                Reading proposal data from this json file
              EOF

              c.flag [:file],
                type: String,
                default_value: nil

              c.desc <<-EOF
                Merge input loaded from server with proposal data
              EOF

              c.switch [:merge],
                negatable: false

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                case
                when opts[:data]
                  json = begin
                    JSON.load opts[:data]
                  rescue
                    exit_now! "Invalid json data"
                  end

                  payload = if opts[:merge]
                    proposal_create_preload(
                      barclamp,
                      proposal
                    ).easy_merge(json)
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
                    proposal_create_preload(
                      barclamp,
                      proposal
                    ).easy_merge(json)
                  else
                    json
                  end
                else
                  begin
                    template = proposal_create_preload(
                      barclamp,
                      proposal
                    )

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
                    say "Successfully created #{proposal} on #{barclamp}"
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
              c.desc <<-EOF
                Reading proposal data from this json string
              EOF

              c.flag [:data],
                type: String,
                default_value: nil

              c.desc <<-EOF
                Reading proposal data from this json file
              EOF

              c.flag [:file],
                type: String,
                default_value: nil

              c.desc <<-EOF
                Merge input loaded from server with proposal data
              EOF

              c.switch [:merge],
                negatable: false

              c.action do |global, opts, args|
                barclamp = args.shift
                proposal = args.shift
                helper.validate_availability_of! barclamp

                case
                when opts[:data]
                  json = begin
                    JSON.load opts[:data]
                  rescue
                    exit_now! "Invalid json data"
                  end

                  payload = if opts[:merge]
                    proposal_update_preload(
                      barclamp,
                      proposal
                    ).easy_merge(json)
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
                    proposal_update_preload(
                      barclamp,
                      proposal
                    ).easy_merge(json)
                  else
                    json
                  end
                else
                  begin
                    original = proposal_update_preload(
                      barclamp,
                      proposal
                    )

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
                    say "Successfully updated #{proposal} on #{barclamp}"
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
                    say "Successfully deleted #{proposal} on #{barclamp}"
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
                    say "Successfully dequeued #{proposal} on #{barclamp}"
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
                    say "Successfully commited #{proposal} on #{barclamp}"
                  when 202
                    say "Successfully queued #{proposal} on #{barclamp}"
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
