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
      #
      # A Thor based CLI wrapper for role commands
      #
      class Role < Base
        desc "list BARCLAMP",
          "List available roles for barclamp"

        long_desc <<-LONGDESC
          `list BARCLAMP` will print out a list of the available roles
          for the specified barclamp. You can display the list in
          different output formats and you can filter the list by any
          search criteria.

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

        def list(barclamp)
          Command::Role::List.new(
            *command_params(
              barclamp: barclamp
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "show BARCLAMP ROLE",
          "Show details of a specific role"

        long_desc <<-LONGDESC
          `show BARCLAMP ROLE` will print out the nodes available to
          assign the role. You can display the details in
          different output formats and you can filter the details by any
          search criteria.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out rows. You can use any substring that is part of
          the found rows.
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

        def show(barclamp, role)
          Command::Role::Show.new(
            *command_params(
              barclamp: barclamp,
              role: role
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
