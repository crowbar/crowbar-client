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
      class Barclamp < Base
        desc "list",
          "List available barclamps"

        long_desc <<-LONGDESC
          `list` will print out a list of the available barclamps on
          the target cloud. You can display the list in different output
          formats and you can filter the list by any search criteria.

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

        def list
          Command::Barclamp::List.new(
            *command_params
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end
      end
    end
  end
end
