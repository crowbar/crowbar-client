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
      class Proposal < Base
        desc "list BARCLAMP",
          "Show a list of available proposals"

        long_desc <<-LONGDESC
          `list BARCLAMP` will print out a list of all available proposals
          for a specific barclamp as a pretty simple and parseable list.
          You can display the list in different output formats and you
          can filter the list by any search criteria.

          With --format <format> option you can choose an output format
          with the available options table, json or plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        def list(barclamp)
          Command::Proposal::List.new(
            *command_params(
              barclamp: barclamp
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "show BARCLAMP PROPOSAL",
          "Show a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `show BARCLAMP PROPOSAL` will try to fetch the configuration
          for the specified proposal of the specified barclamp. If you
          just want to see a specific subset of the configuration you
          can provide the --filter option separated by a dot for every
          element. If you want to get into details of array structures
          you can use the array index starting at 0 as a path segment
          to get further details.

          With --format <format> option you can choose an output format
          with the available options table, json or plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        def show(barclamp, proposal)
          Command::Proposal::Show.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "create BARCLAMP PROPOSAL",
          "Create a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `create BARCLAMP PROPOSAL` will create a new proposal for the
          specified barclamp. There are multiple options how you can
          provide the content. If you provide the data with the --data
          or --file option the action is non interactive. If you provide
          no option an editor will start automatically and loads a
          template from the server.

          With --data <json> option you can provide the proposal content
          in JSON formatted as a string.

          With --file <file> option you can provide a path to a file
          which includes the content for the proposal in JSON format.

          With --merge option you can deep merge the provided data with
          the preloaded template.
        LONGDESC

        method_option :data,
          type: :string,
          default: nil,
          banner: "<json>",
          desc: "Reading proposal data from this json string"

        method_option :file,
          type: :string,
          default: nil,
          banner: "<file>",
          desc: "Reading proposal data from this json file"

        class_option :merge,
          type: :boolean,
          default: false,
          aliases: ["-m"],
          desc: "Merge input loaded from server with proposal data"

        def create(barclamp, proposal)
          Command::Proposal::Create.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "edit BARCLAMP PROPOSAL",
          "Edit a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `edit BARCLAMP PROPOSAL` will update an existing proposal for
          the specified barclamp. There are multiple options how you can
          provide the content. If you provide the data with the --data
          or --file option the action is non interactive. If you provide
          no option an editor will start automatically and loads the
          existing proposal from the server.

          With --data <json> option you can provide the proposal content
          in JSON formatted as a string.

          With --file <file> option you can provide a path to a file
          which includes the content for the proposal in JSON format.

          With --merge option you can deep merge the provided data with
          the preloaded proposal.
        LONGDESC

        method_option :data,
          type: :string,
          default: nil,
          banner: "<json>",
          desc: "Reading proposal data from this json string"

        method_option :file,
          type: :string,
          default: nil,
          banner: "<file>",
          desc: "Reading proposal data from this json file"

        class_option :merge,
          type: :boolean,
          default: false,
          aliases: ["-m"],
          desc: "Merge input loaded from server with proposal data"

        def edit(barclamp, proposal)
          Command::Proposal::Edit.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "delete BARCLAMP PROPOSAL",
          "Delete a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `delete BARCLAMP PROPOSAL` will try to remove the specified
          proposal for the specified barclamp.
        LONGDESC

        def delete(barclamp, proposal)
          Command::Proposal::Delete.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "dequeue BARCLAMP PROPOSAL",
          "Dequeue a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `dequeue BARCLAMP PROPOSAL` will try to dequeue the specified
          proposal for the specified barclamp.
        LONGDESC

        def dequeue(barclamp, proposal)
          Command::Proposal::Dequeue.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "commit BARCLAMP PROPOSAL",
          "Commit a proposal for specific barclamp"

        long_desc <<-LONGDESC
          `commit BARCLAMP PROPOSAL` will try to commit the specified
          proposal for the specified barclamp.
        LONGDESC

        def commit(barclamp, proposal)
          Command::Proposal::Commit.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end
      end
    end
  end
end
