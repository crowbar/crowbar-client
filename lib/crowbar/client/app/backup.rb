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
          `list` will print out a list of existing backups on the admin
          node. You can display the list in different output
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
          `create NAME` will create a new backup on the Administration Server.
        LONGDESC

        def create(name)
          Command::Backup::Create.new(
            *command_params(
              backup: name
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "download",
          "Download a backup"

        long_desc <<-LONGDESC
          `download ID` will download a backup from the Administration Server.
        LONGDESC

        def download(id)
          Command::Backup::Download.new(
            *command_params(
              id: id
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "upload",
          "Upload a backup"

        long_desc <<-LONGDESC
          `upload FILE` will upload a backup to the Administration Server.
        LONGDESC

        def upload(file)
          Command::Backup::Upload.new(
            *command_params(
              file: File.new(
                file
              )
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "delete",
          "Delete a backup"

        long_desc <<-LONGDESC
          `delete ID` will delete a backup from the Administration Server.
        LONGDESC

        def delete(id)
          Command::Backup::Delete.new(
            *command_params(
              id: id
            )
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
