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
      module Node
        extend ActiveSupport::Concern

        included do
          desc "Node specific commands"
          command :node do |parent|
            parent.desc "Show current nodes status"
            parent.command :status do |c|
              c.desc "Format of the resulting output"
              c.flag [:format], type: String, default_value: :table

              c.desc "Filter output by criteria"
              c.flag [:filter], type: String, default_value: nil

              c.action do |global, opts, args|
                Request.instance.node_status do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body).with_indifferent_access
                    rescue
                      {}
                    end

                    # TODO(must): Implement filter method
                    case opts[:format].to_sym
                    when :table
                      rows = [].tap do |result|
                        body[:nodes].each do |name, data|
                          result.push([
                            name,
                            data[:status]
                          ])
                        end
                      end

                      say Terminal::Table.new(
                        rows:     rows.sort,
                        headings: [
                          "Name",
                          "Status"
                        ]
                      )
                    when :json
                      rows = [].tap do |result|
                        body[:nodes].each do |name, data|
                          result.push(
                            name:   name,
                            status: data[:status]
                          )
                        end
                      end

                      say JSON.pretty_generate(
                        rows.sort_by { |r| r[:name] }
                      )
                    else
                      err "Invalid format, valid formats: table, json"
                    end
                  when 404
                    err "Failed to find any available node"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Show a list of available nodes"
            parent.command :list do |c|
              c.desc "Format of the resulting output"
              c.flag [:format], type: String, default_value: :table

              c.desc "Filter output by criteria"
              c.flag [:filter], type: String, default_value: nil

              c.action do |global, opts, args|
                Request.instance.node_list do |request|
                  case request.code
                  when 200
                    body = begin
                      JSON.parse(request.body).with_indifferent_access
                    rescue
                      {}
                    end

                    # TODO(must): Implement filter method
                    case opts[:format].to_sym
                    when :table
                      rows = [].tap do |result|
                        body[:nodes].each do |data|
                          result.push([
                            data[:name],
                            data[:alias]
                          ])
                        end
                      end

                      say Terminal::Table.new(
                        rows:     rows.sort,
                        headings: [
                          "Name",
                          "Alias"
                        ]
                      )
                    when :json
                      rows = [].tap do |result|
                        body[:nodes].each do |data|
                          result.push(
                            name:  data[:name],
                            alias: data[:alias]
                          )
                        end
                      end

                      say JSON.pretty_generate(
                        rows.sort_by { |r| r[:name] }
                      )
                    else
                      err "Invalid format, valid formats: table, json"
                    end
                  when 404
                    err "Failed to find any available node"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Hardware update a node"
            parent.arg :name_or_alias
            parent.command :hardware do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:update, name) do |request|
                  case request.code
                  when 200
                    say "Executed hardware for #{name}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Identify the specified node"
            parent.arg :name_or_alias
            parent.command :identify do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:identify, name) do |request|
                  case request.code
                  when 200
                    say "Executed identify for #{name}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Delete the specified node"
            parent.arg :name_or_alias
            parent.command :delete do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_delete(name) do |request|
                  case request.code
                  when 200
                    say "Deleted successfully #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Reinstall the specified node"
            parent.arg :name_or_alias
            parent.command :reinstall do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:reinstall, name) do |request|
                  case request.code
                  when 200
                    say "Executed reinstall for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Reset the specified node"
            parent.arg :name_or_alias
            parent.command :reset do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:reset, name) do |request|
                  case request.code
                  when 200
                    say "Executed reset for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Shutdown the specified node"
            parent.arg :name_or_alias
            parent.command :shutdown do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:reset, name) do |request|
                  case request.code
                  when 200
                    say "Executed shutdown for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Reboot the specified node"
            parent.arg :name_or_alias
            parent.command :reboot do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:reboot, name) do |request|
                  case request.code
                  when 200
                    say "Executed reboot for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Powercycle the specified node"
            parent.arg :name_or_alias
            parent.command :powercycle do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:powercycle, name) do |request|
                  case request.code
                  when 200
                    say "Executed powercycle for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Poweroff the specified node"
            parent.arg :name_or_alias
            parent.command :poweroff do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:poweroff, name) do |request|
                  case request.code
                  when 200
                    say "Executed poweroff for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Poweron the specified node"
            parent.arg :name_or_alias
            parent.command :poweron do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:poweron, name) do |request|
                  case request.code
                  when 200
                    say "Executed poweron for #{name}"
                  when 403
                    err "Not allowed for an admin server"
                  when 404
                    err "Name does not exist"
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Allocate the specified node"
            parent.arg :name_or_alias
            parent.command :allocate do |c|
              c.action do |global, opts, args|
                name = args.shift

                Request.instance.node_action(:allocate, name) do |request|
                  case request.code
                  when 200
                    say "Executed allocate for #{name}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Assign an intended role to a node"
            parent.arg :name_or_alias
            parent.arg :role
            parent.command :role do |c|
              c.action do |global, opts, args|
                name = args.shift
                update = args.shift

                Request.instance.node_role(name, update) do |request|
                  body = begin
                    JSON.parse(request.body).with_indifferent_access
                  rescue
                    {}
                  end

                  case request.code
                  when 200
                    say "Executed allocate for #{name}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Set an alias for a node"
            parent.arg :name_or_alias
            parent.arg :alias
            parent.command :rename do |c|
              c.action do |global, opts, args|
                name = args.shift
                update = args.shift

                Request.instance.node_rename(name, update) do |request|
                  body = begin
                    JSON.parse(request.body).with_indifferent_access
                  rescue
                    {}
                  end

                  case request.code
                  when 200
                    say "Executed allocate for #{name}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Show a specific node config"
            parent.arg :name_or_alias
            parent.arg :path, :optional
            parent.command :show do |c|
              c.action do |global, opts, args|
                name = args.shift
                path = args.shift

                Request.instance.node_show(name) do |request|
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
                    err "Name does not exist"
                  when 422
                    err body[:error]
                  else
                    err "Got unknown response with code #{request.code}"
                  end
                end
              end
            end

            parent.desc "Transition a node to a specific state"
            parent.arg :name_or_alias
            parent.arg :state
            parent.command :transition do |c|
              c.action do |global, opts, args|
                name = args.shift
                state = args.shift

                Request.instance.node_transition(name, state) do |request|
                  case request.code
                  when 200
                    say "Transitioned #{name} into #{state}"
                  when 404
                    err "Name does not exist"
                  when 422
                    err body[:error]
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
