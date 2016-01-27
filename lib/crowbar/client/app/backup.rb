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
      class Backup < Base
        desc "list",
          "List existing backups"

        long_desc <<-LONGDESC
          `list` will print out a list of existing backups on the server.
          You can display the list in different output formats and you
          can filter the list by any search criteria.

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

        def list
          Command::Backup::List.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "create",
          "Create a new backup"

        long_desc <<-LONGDESC
          `create NAME` will trigger the creation of a new backup on the
          server, to download the backup after processing you can use the
            download command.
        LONGDESC

        def create(name)
          Command::Backup::Create.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "delete",
          "Delete a backup"

        long_desc <<-LONGDESC
          `delete NAME` will delete a backup from the server. Be careful
          with that command, you are not able to restore this file after
          deletion.
        LONGDESC

        def delete(name)
          Command::Backup::Delete.new(
            *command_params(
              name: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "upload",
          "Upload a backup"

        long_desc <<-LONGDESC
          `upload FILE` will upload a backup to the server. You can use
          this backup later to trigger a restore.
        LONGDESC

        def upload(file)
          Command::Backup::Upload.new(
            *command_params(
              file: file
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "download",
          "Download a backup"

        long_desc <<-LONGDESC
          `download NAME [FILE]` will download a backup from the server. If
          you specify a `file` the download gets written to that file,
          otherwise it gets saved to the current working directory with an
          automatically generated filename. You can directly provide a path
          to a file or just pipe the content to stdout. To pipe the content
          to stdout you should just write a `-` instead of a specific
          filename.
        LONGDESC

        def download(name, file = nil)
          Command::Backup::Download.new(
            *command_params(
              name: name,
              file: file
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
