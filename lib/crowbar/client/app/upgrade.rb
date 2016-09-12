#
# Copyright 2016, SUSE Linux GmbH
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
      # A Thor based CLI wrapper for upgrade commands
      #
      class Upgrade < Base
        desc "status",
          "Show the status of the upgrade"

        long_desc <<-LONGDESC
          `status` will print out a status of the upgrade.
          You can display the status in different output formats
          and you can filter the list by any search criteria.

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

        def status
          Command::Upgrade::Status.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "prepare",
          "Prepare Crowbar upgrade"

        long_desc <<-LONGDESC
          `prepare` will set the nodes to upgrading state
        LONGDESC

        def prepare
          Command::Upgrade::Prepare.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "services",
          "Stop related services on all nodes during upgrade"

        long_desc <<-LONGDESC
          `services` will stop all related services on all nodes
          during the upgrade.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out rows. You can use any substring that is part of
          the found rows.
        LONGDESC

        def services
          Command::Upgrade::Services.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "prechecks",
          "Perform checks to make sure Crowbar can be upgraded"

        long_desc <<-LONGDESC
          `prechecks` will perform a sanity check on the Crowbar server to
          make sure that the server, nodes and services can be upgraded.

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

        def prechecks
          Command::Upgrade::Prechecks.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "crowbar",
          "Upgrade Crowbar"

        long_desc <<-LONGDESC
          `crowbar` will upgrade the operating system of the Crowbar server.
        LONGDESC

        def crowbar
          Command::Upgrade::Crowbar.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "node NODE",
          "Upgrade a single node"

        long_desc <<-LONGDESC
          `node NODE` will upgrade the operating system of a single node.
        LONGDESC

        def node(node)
          Command::Upgrade::Node.new(
            *command_params(
              node: node
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "backup COMPONENT",
          "Create a backup of a component (crowbar|openstack)"

        long_desc <<-LONGDESC
          `backup COMPONENT` will create a backup of Crowbar or the
          OpenStack database. COMPONENT can be 'crowbar' or 'openstack'
        LONGDESC

        def backup(component)
          Command::Upgrade::Backup.new(
            *command_params(
              component: component
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "repocheck COMPONENT",
          "Check for existing repositories for a component (crowbar|nodes)"

        long_desc <<-LONGDESC
          `repocheck COMPONENT` will check for existing repositories
          for a specific component. COMPONENT can be 'crowbar' or 'nodes'

          crowbar: checks for the repositories required to upgrade the crowbar
          server

          nodes: checks for the repositories required to upgrade the nodes, plus
          an optional check if the SUSE Enterprise Storage or/and the SUSE Linux
          Enterprise High Availability Addon is installed

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

        def repocheck(component)
          Command::Upgrade::Repocheck.new(
            *command_params(
              component: component
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
