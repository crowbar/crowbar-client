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
      # A Thor based CLI entry point which resolves the sub-commands
      #
      class Entry < Base
        check_unknown_options!

        map [
          "--version",
          "-v"
        ] => :version

        map [
          "--help",
          "-h"
        ] => :help

        class_option :alias,
          type: :string,
          default: Config.defaults[:alias],
          aliases: ["-a"],
          desc: "Alias for a config section"

        class_option :username,
          type: :string,
          default: Config.defaults[:username],
          aliases: ["-U"],
          desc: "Specify username for connection"

        class_option :password,
          type: :string,
          default: Config.defaults[:password],
          aliases: ["-P"],
          desc: "Specify password for connection"

        class_option :server,
          type: :string,
          default: Config.defaults[:server],
          aliases: ["-s"],
          desc: "Specify server for connection"

        class_option :verify_ssl,
          type: :boolean,
          default: Config.defaults[:verify_ssl],
          aliases: ["-i"],
          desc: "Verify server SSL certificate"

        class_option :timeout,
          type: :numeric,
          default: Config.defaults[:timeout],
          aliases: ["-t"],
          desc: "Specify timeout for connection"

        class_option :anonymous,
          type: :boolean,
          default: Config.defaults[:anonymous],
          aliases: ["-A"],
          desc: "Skip API user authentication"

        class_option :apiversion,
          type: :numeric,
          default: Config.defaults[:apiversion],
          aliases: ["-v"],
          desc: "Select Crowbar API version"

        class_option :debug,
          type: :boolean,
          default: Config.defaults[:debug],
          aliases: ["-d"],
          desc: "Output more debug information"

        # TODO(should): Prevent a --no-help alternative flag
        # class_option :help,
        #   type: :boolean,
        #   aliases: ["-h"],
        #   desc: "Print this help information"

        # TODO(should): Prevent a --no-version alternative flag
        # class_option :version,
        #   type: :boolean,
        #   aliases: ["-v"],
        #   desc: "Print the current version of the CLI"

        desc "version",
          "Display the current version of the client"

        long_desc <<-LONGDESC
          `version` will print out the version of the currently used
          crowbar-client, this is some usefull information if you try
          to debug some issue with the current implementation.
        LONGDESC

        #
        # Command to print the version of Crowbar CLI
        #
        def version
          say "crowbar-client v#{Crowbar::Client::Version}"
        end

        desc "backup [COMMANDS]",
          "Backup specific commands, call without params for help"
        subcommand "backup", Crowbar::Client::App::Backup

        desc "barclamp [COMMANDS]",
          "Barclamp specific commands, call without params for help"
        subcommand "barclamp", Crowbar::Client::App::Barclamp

        desc "batch [COMMANDS]",
          "Batch specific commands, call without params for help"
        subcommand "batch", Crowbar::Client::App::Batch

        desc "network [COMMANDS]",
          "Network specific commands, call without params for help"
        subcommand "network", Crowbar::Client::App::Network

        desc "node [COMMANDS]",
          "Node specific commands, call without params for help"
        subcommand "node", Crowbar::Client::App::Node

        desc "proposal [COMMANDS]",
          "Proposal specific commands, call without params for help"
        subcommand "proposal", Crowbar::Client::App::Proposal

        desc "repository [COMMANDS]",
          "Repository specific commands, call without params for help"
        subcommand "repository", Crowbar::Client::App::Repository

        desc "role [COMMANDS]",
          "Role specific commands, call without params for help"
        subcommand "role", Crowbar::Client::App::Role

        desc "server [COMMANDS]",
          "Server specific commands, call without params for help"
        subcommand "server", Crowbar::Client::App::Server

        desc "installer [COMMANDS]",
          "Installer specific commands, call without params for help"
        subcommand "installer", Crowbar::Client::App::Installer

        desc "upgrade [COMMANDS]",
          "Upgrade specific commands, call without params for help"
        subcommand "upgrade", Crowbar::Client::App::Upgrade

        desc "database [COMMANDS]",
          "Database specific commands, call without params for help"
        subcommand "database", Crowbar::Client::App::Database

        desc "services [COMMANDS]",
          "Services specific commands, call without params for help"
        subcommand "services", Crowbar::Client::App::Services
      end
    end
  end
end
