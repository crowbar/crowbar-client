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
    module App
      class Node < Base
        desc "status",
          "Show current nodes status"

        long_desc <<-LONGDESC
          `status` will print out a list of nodes and will display some
          information about the current status if it gets installed or
          if it is in a ready state. You can display the list in different
          output formats and you can filter the list by any search criteria.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.

          With --no-ready switch you can hide all nodes that already
          transitioned to the ready state, per default the listing will
          display all nodes.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :table,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :json,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :plain,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        method_option :ready,
          type: :boolean,
          default: true,
          aliases: [],
          desc: "Show or hide the nodes that already transitioned to ready"

        def status
          Command::Node::Status.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "list",
          "Show a list of available nodes"

        long_desc <<-LONGDESC
          `list` will print out a list of all available nodes as a
          pretty simple and parseable list. You can display the list
          in different output formats and you can filter the list by
          any search criteria.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.

          With --no-meta switch you can disable the additional information
          and just get a list of names and aliases for further scripting
          where you don't care about the other columns.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :table,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :json,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format json option"

        method_option :plain,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format plain option"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        method_option :meta,
          type: :boolean,
          default: true,
          aliases: [],
          desc: "Show or hide the additional meta info like group and status"

        def list
          Command::Node::List.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "show NAME_OR_ALIAS",
          "Show a specific node config"

        long_desc <<-LONGDESC
          `show NAME_OR_ALIAS` will try to fetch the configuration
          for the specified node. If you just want to see a specific
          subset of the configuration you can provide the --filter
          option separated by a dot for every element. If you want
          to get into details of array structures you can use the
          array index starting at 0 as a path segment to get further
          details.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :table,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :json,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :plain,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        def show(name)
          Command::Node::Show.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "hardware NAME_OR_ALIAS",
          "Hardware update a node"

        long_desc <<-LONGDESC
          `hardware NAME_OR_ALIAS` will try to invoke a hardware update
          for the specified node.
        LONGDESC

        def hardware(name)
          Command::Node::Hardware.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "identify NAME_OR_ALIAS",
          "Identify the specified node"

        long_desc <<-LONGDESC
          `identify NAME_OR_ALIAS` will try to indentify the specified
          node.
        LONGDESC

        def identify(name)
          Command::Node::Identify.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "delete NAME_OR_ALIAS",
          "Delete the specified node"

        long_desc <<-LONGDESC
          `delete NAME_OR_ALIAS` will try to remove the specified
          node.
        LONGDESC

        def delete(name)
          Command::Node::Delete.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "reinstall NAME_OR_ALIAS",
          "Reinstall the specified node"

        long_desc <<-LONGDESC
          `reinstall NAME_OR_ALIAS` will try to reinstall the specified
          node.
        LONGDESC

        def reinstall(name)
          Command::Node::Reinstall.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "reset NAME_OR_ALIAS",
          "Reset the specified node"

        long_desc <<-LONGDESC
          `reset NAME_OR_ALIAS` will try to reset the specified
          node.
        LONGDESC

        def reset(name)
          Command::Node::Reset.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "shutdown NAME_OR_ALIAS",
          "Shutdown the specified node"

        long_desc <<-LONGDESC
          `shutdown NAME_OR_ALIAS` will try to shutdown the specified
          node.
        LONGDESC

        def shutdown(name)
          Command::Node::Shutdown.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "reboot NAME_OR_ALIAS",
          "Reboot the specified node"

        long_desc <<-LONGDESC
          `reboot NAME_OR_ALIAS` will try to reboot the specified
          node.
        LONGDESC

        def reboot(name)
          Command::Node::Reboot.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "powercycle NAME_OR_ALIAS",
          "Powercycle the specified node"

        long_desc <<-LONGDESC
          `powercycle NAME_OR_ALIAS` will try to powercycle the specified
          node.
        LONGDESC

        def powercycle(name)
          Command::Node::Powercycle.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "poweroff NAME_OR_ALIAS",
          "Poweroff the specified node"

        long_desc <<-LONGDESC
          `poweroff NAME_OR_ALIAS` will try to poweroff the specified
          node.
        LONGDESC

        def poweroff(name)
          Command::Node::Poweroff.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "poweron NAME_OR_ALIAS",
          "Poweron the specified node"

        long_desc <<-LONGDESC
          `poweron NAME_OR_ALIAS` will try to poweron the specified
          node.
        LONGDESC

        def poweron(name)
          Command::Node::Poweron.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "allocate NAME_OR_ALIAS",
          "Allocate the specified node"

        long_desc <<-LONGDESC
          `allocate NAME_OR_ALIAS` will try to allocate the specified
          node.
        LONGDESC

        def allocate(name)
          Command::Node::Allocate.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "role NAME_OR_ALIAS ROLE",
          "Assign an intended role to a node"

        long_desc <<-LONGDESC
          `role NAME_OR_ALIAS ROLE` will try to assign a intended role
          to the specified node.
        LONGDESC

        def role(name, value)
          Command::Node::Role.new(
            *command_params(
              name: name,
              value: value
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "rename NAME_OR_ALIAS ALIAS",
          "Assign an alias for a node"

        long_desc <<-LONGDESC
          `rename NAME_OR_ALIAS ALIAS` will try to assign an alias to
          the specified node.
        LONGDESC

        def rename(name, value)
          Command::Node::Rename.new(
            *command_params(
              name: name,
              value: value
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "group NAME_OR_ALIAS GROUP",
          "Assign another group to a node"

        long_desc <<-LONGDESC
          `group NAME_OR_ALIAS GROUP` will try to assign the specified
          node to a different group. If you want to guess a group
          automatically you can provide the group "automatic", then you
          will get the new name as a response.
        LONGDESC

        def group(name, value)
          Command::Node::Group.new(
            *command_params(
              name: name,
              value: value
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "transition NAME_OR_ALIAS STATE",
          "Transition a node to a specific state"

        long_desc <<-LONGDESC
          `transition NAME_OR_ALIAS STATE` will try totransition the
          specified node into a specified state.
        LONGDESC

        def transition(name, state)
          Command::Node::Transition.new(
            *command_params(
              name: name,
              state: state
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
