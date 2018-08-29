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
      # A Thor based CLI wrapper for installer commands
      #
      class Installer < Base
        desc "status",
          "Show current installer status"

        long_desc <<-LONGDESC
          `status` will print out information about the current status
          of the installer. You can display the list in different output
          formats and you can filter the list by any search criteria.

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

        #
        # Installer status command
        #
        # It will print out information about the current status of the
        # installer. You can display the list in different output formats
        # and you can filter the list by any search criteria.
        #
        def status
          Command::Installer::Status.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "start",
          "Start the insallation of Crowbar"

        long_desc <<-LONGDESC
          `start` will trigger the installation of the server.

          With --force you can enforce a reinstallation if the installation
          has already been finished. Be careful with that option as you will
          destroy an already existing installation.
        LONGDESC

        method_option :force,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Force Administration Server installation"

        #
        # Installer start command
        #
        # It will trigger the installation of the server.
        #
        def start
          Command::Installer::Start.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
