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

require "gli"

GLI::Commands::Help.tap do |config|
  config.skips_around = false
  config.skips_pre = false
  config.skips_post = false
end

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

      desc "Path to a configuration file"
      flag [:c, :config], default_value: nil

      desc "Alias for a config section"
      flag [:a, :alias], default_value: "default"

      desc "Specify username for connection"
      flag [:U, :username], default_value: "crowbar"

      desc "Specify password for connection"
      flag [:P, :password], default_value: "crowbar"

      desc "Specify host for connection"
      flag [:n, :hostname], default_value: "http://127.0.0.1"

      desc "Specify port for connection"
      flag [:p, :port], default_value: "80"

      desc "Specify timeout for connection"
      flag [:t, :timeout], default_value: "60"

      desc "Output debug informations"
      switch [:d, :debug], negatable: false

      desc "Call legacy routes for 1.x compatibility"
      switch [:l, :legacy], negatable: false

      pre do |global|
        ENV["GLI_DEBUG"] = "true" if global[:debug]

        config = configure(global[:config], global[:alias])

        Request::Party.instance.configure(
          host:     config[:hostname] || global[:hostname],
          port:     config[:port] || global[:port],
          username: config[:username] || global[:username],
          password: config[:password] || global[:password],
          legacy:   config[:legacy] || global[:legacy],
          debug:    config[:debug] || global[:debug],
          timeout:  config[:timeout] || global[:timeout]
        )

        true
      end

      include Cli::Helper

      include Command::Barclamps
      include Command::Batch
      include Command::Network
      include Command::Node
      include Command::Proposal
      include Command::Reset
      include Command::Role
      include Command::Repository
    end
  end
end
