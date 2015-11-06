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
      class Batch < Base
        desc "build FILE",
          "Build proposals from file or stdin"

        long_desc <<-LONGDESC
          `build FILE` will create/edit/commit proposals defined in
          an YAML format. You can directly provide a path to a file or
          just pipe the content from stdin. To pipe the content from
          stdin you should just write a `-` instead of a specific
          filename.

          With --include <barclamp[.proposal]> option you can process
          only a specific part from the provided YAML file structure.

          With --exclude <barclamp[.proposal]> option you exclude
          specific parts from the provided YAML file structure to be
          processed.
        LONGDESC

        method_option :include,
          type: :string,
          default: nil,
          banner: "<barclamp[.proposal]>",
          desc: "Include a specific barclamp or proposal for processing"

        method_option :exclude,
          type: :string,
          default: nil,
          banner: "<barclamp[.proposal]>",
          desc: "Exclude a specific barclamp or proposal for processing"

        def build(file)
          Command::Batch::Build.new(
            *command_params(
              file: file
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end

        desc "export PROPOSAL [PROPOSAL]",
          "Export proposals to stdout"

        long_desc <<-LONGDESC
          `export PROPOSAL [PROPOSAL]` will collect the informations
          for the provided proposals and print it out to stdout in a
          YAML format that can be used to build again.

          With --include <barclamp[.proposal]> option you can export
          only a specific part from the existing proposals.

          With --exclude <barclamp[.proposal]> option you exclude
          specific parts from the existing proposals to be exported.
        LONGDESC

        method_option :include,
          type: :string,
          default: nil,
          banner: "<barclamp[.proposal]>",
          desc: "Include a specific barclamp or proposal for export"

        method_option :exclude,
          type: :string,
          default: nil,
          banner: "<barclamp[.proposal]>",
          desc: "Exclude a specific barclamp or proposal for export"

        def export(*proposals)
          Command::Batch::Export.new(
            *command_params(
              proposals: proposals
            )
          ).execute
        rescue SimpleCatchableError => e
          err e.message, 1
        end
      end
    end
  end
end
