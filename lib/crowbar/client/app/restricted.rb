#
# Copyright 2019, SUSE
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
      #
      # A Thor based CLI wrapper for restricted commands
      #
      class Restricted < Base
        desc "allocate NAME_OR_ALIAS",
          "Allocate the specified node"

        long_desc <<-LONGDESC
          `allocate NAME_OR_ALIAS` will try to allocate the specified
          node.
        LONGDESC

        def allocate(name)
          Command::Restricted::Allocate.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "ping",
          "Ping the administration server"

        long_desc <<-LONGDESC
          `ping` will check that the administration server is up.
        LONGDESC

        def ping
          Command::Restricted::Ping.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "show NAME_OR_ALIAS",
          "Show restricted data for a specific node"

        long_desc <<-LONGDESC
          `show NAME_OR_ALIAS` will try to fetch the restricted data
          for the specified node. If you just want to see a specific
          subset of the restricted data you can provide the --filter
          option separated by a dot for every element.

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
          desc: "Format output as json, a shortcut for --format json option"

        method_option :plain,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as plain text, a shortcut for --format plain option"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        def show(name)
          Command::Restricted::Show.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "transition NAME_OR_ALIAS STATE",
          "Transition a node to a specific state"

        long_desc <<-LONGDESC
          `transition NAME_OR_ALIAS STATE` will try to transition the
          specified node into a specified state.
        LONGDESC

        def transition(name, state)
          Command::Restricted::Transition.new(
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
