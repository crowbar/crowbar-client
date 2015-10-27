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
      module Repository
        extend ActiveSupport::Concern

        included do
          desc "Repository specific commands"
          command "repository" do |parent|
            parent.desc "Show a list of available repositories"
            parent.command "list" do |c|
              c.desc "Format of the resulting output"
              c.flag [:format], type: String, default_value: :table

              c.desc "Filter output by criteria"
              c.flag [:filter], type: String, default_value: nil

              c.action do |global, opts, args|
                Request.instance.repository_list do |request|
                  case request.code
                  when 200
                    rows = [].tap do |row|
                      request.parsed_response.each do |repository|
                        row.push(
                          platform: repository["platform"],
                          repo: repository["id"]
                        )
                      end
                    end

                    formatter = Formatter::Hash.new(
                      format: opts[:format],
                      headings: ["Platform", "Repo"],
                      values: Filter::Hash.new(
                        filter: opts[:filter],
                        values: rows
                      ).result
                    )

                    if formatter.empty?
                      exit_now! "No repositories"
                    else
                      say formatter.result
                    end
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Activate a repository for a platform"
            parent.arg :platform
            parent.arg :repo
            parent.command "activate" do |c|
              c.action do |global, opts, args|
                platform = args.shift
                repo = args.shift

                Request.instance.repository_activate(platform, repo) do |request|
                  case request.code
                  when 200
                    say "Successfully activated #{repo} on #{platform}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Activate all repositories"
            parent.command "activate-all" do |c|
              c.action do |global, opts, args|
                Request.instance.repository_activate_all do |request|
                  case request.code
                  when 200
                    say "Successfully activated all repositories"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Deactivate a repository for a platform"
            parent.arg :platform
            parent.arg :repo
            parent.command "deactivate" do |c|
              c.action do |global, opts, args|
                platform = args.shift
                repo = args.shift

                Request.instance.repository_deactivate(platform, repo) do |request|
                  case request.code
                  when 200
                    say "Successfully deactivated #{repo} on #{platform}"
                  else
                    exit_now! request.parsed_response["error"]
                  end
                end
              end
            end

            parent.desc "Deactivate all repositories"
            parent.command "deactivate-all" do |c|
              c.action do |global, opts, args|
                Request.instance.repository_deactivate_all do |request|
                  case request.code
                  when 200
                    say "Successfully deactivated all repositories"
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
