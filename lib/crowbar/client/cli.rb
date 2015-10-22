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

require_relative "cli/helper"
require_relative "cli/flags"
require_relative "cli/hooks"

module Crowbar
  module Client
    class Cli
      extend GLI::App

      program_desc "Standalone commandline client for Crowbar"
      version Crowbar::Client::Version

      subcommand_option_handling :normal
      arguments :strict

      accept Array do |value|
        value.split(/,/).map(&:strip)
      end

      include Cli::Helper
      include Cli::Flags
      include Cli::Hooks

      include Command::Barclamps
      include Command::Batch
      include Command::Network
      include Command::Node
      include Command::Proposal
      include Command::Reset
      include Command::Role
    end
  end
end
