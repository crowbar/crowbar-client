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
      module Upgrade
        #
        # Implementation for the upgrade repocheck command
        #
        class Repocheck < Base
          include Mixin::Format
          include Mixin::Filter
          include Mixin::UpgradeError

          def request
            @request ||= Request::Upgrade::Repocheck.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                hint = ""
                if provide_format == :table
                  response = request.parsed_response
                  repos = {}
                  response.each do |type, type_data|
                    type_data["repos"].each do |repo|
                      next if repo.nil?
                      repos[repo] = { repo: repo, status: [], type: type } unless repos.key? repo
                    end
                    type_data["errors"].each do |error, error_data|
                      error_data.each do |arch, bad_repos|
                        bad_repos.each do |bad_repo|
                          hint = "Some repopositories are not available. " \
                            "Fix the problem and call the step again."
                          repos[bad_repo][:status] << "#{error} (#{arch})"
                        end
                      end
                    end
                  end

                  repos.values.each do |repo|
                    repo[:status] = repo[:status].uniq.join(", ")
                    repo[:status] = "available" if repo[:status].empty?
                  end

                  formatter = Formatter::Hash.new(
                    format: provide_format,
                    headings: ["Repository", "Status", "Type"],
                    values: Filter::Hash.new(
                      filter: provide_filter,
                      values: repos.values
                    ).result
                  )
                else
                  formatter = Formatter::Nested.new(
                    format: provide_format,
                    values: Filter::Subset.new(
                      filter: provide_filter,
                      values: request.parsed_response
                    ).result
                  )
                end

                if formatter.empty?
                  err "No repochecks"
                else
                  say formatter.result
                  next unless provide_format == :table
                  say hint unless hint.empty?
                  say "Next step: 'crowbarctl upgrade admin'" if args.component == "crowbar"
                  say "Next step: 'crowbarctl upgrade services'" if args.component == "nodes"
                end
              else
                case args.component
                when "crowbar"
                  err format_error(
                    request.parsed_response["error"], "repocheck_crowbar"
                  )
                when "nodes"
                  err format_error(
                    request.parsed_response["error"], "repocheck_nodes"
                  )
                else
                  err "No such component '#{args.component}'. " \
                    "Only 'admin' and 'nodes' are valid components."
                end
              end
            end
          end
        end
      end
    end
  end
end
