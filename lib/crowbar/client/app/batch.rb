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

          With --includes BARCLAMP[.PROPOSAL] option you can process
          only a specific part from the provided YAML file structure,
          if you don't provide a proposal name we will take the `default`
          proposal. This option allows multiple values, separated by a
          `,` from each other.

          With --excludes BARCLAMP[.PROPOSAL] option you exclude
          specific parts from the provided YAML file structure to be
          processed, if you don't provide a proposal name we will take
          the `default` proposal. This option allows multiple values,
          separated by a `,` from each other.
        LONGDESC

        method_option :includes,
          type: :array,
          default: [],
          banner: "BARCLAMP[.PROPOSAL]",
          desc: "Include a specific barclamp or proposal for processing"

        method_option :excludes,
          type: :array,
          default: [],
          banner: "BARCLAMP[.PROPOSAL]",
          desc: "Exclude a specific barclamp or proposal for processing"

        def build(file)
          Command::Batch::Build.new(
            *command_params(
              file: file
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "export FILE",
          "Export proposals to file or stdout"

        long_desc <<-LONGDESC
          `export FILE` will collect the informations of the proposals
          in a YAML format. You can directly provide a path to a file or
          just pipe the content into stdout. To pipe the content to
          stdout you should just write a `-` instead of a specific
          filename.

          With --includes BARCLAMP[.PROPOSAL] option you can export
          only a specific part from the existing proposals, if you don't
          provide a proposal name we will take the `default` proposal.
          This option allows multiple values, separated by a `,` from
          each other.

          With --excludes BARCLAMP[.PROPOSAL] option you exclude specific
          parts from the existing proposals to be exported, if you don't
          provide a proposal name we will take the `default` proposal.
          This option allows multiple values, separated by a `,` from
          each other.
        LONGDESC

        method_option :includes,
          type: :array,
          default: [],
          banner: "BARCLAMP[.PROPOSAL]",
          desc: "Include a specific barclamp or proposal for export"

        method_option :excludes,
          type: :array,
          default: [],
          banner: "BARCLAMP[.PROPOSAL]",
          desc: "Exclude a specific barclamp or proposal for export"

        def export(file)
          Command::Batch::Export.new(
            *command_params(
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
