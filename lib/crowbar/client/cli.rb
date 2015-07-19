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
      flag [:p, :port], default_value: "3000"

      desc "Specify timeout for connection"
      flag [:t, :timeout], default_value: "60"

      desc "Output debug informations"
      switch [:d, :debug], negatable: false

      pre do |global|
        config = configure(global[:config], global[:alias])

        # TODO(optional): How can we improve this?
        $request = Request.new(
          host: config[:hostname] || global[:hostname],
          port: config[:port] || global[:port],
          username: config[:username] || global[:username],
          password: config[:password] || global[:password],
          debug: config[:debug] || global[:debug],
          timeout: config[:timeout] || global[:timeout]
        )

        true
      end

      include Command::Barclamps
      include Command::Batch
      include Command::Node
      include Command::Proposal
      include Command::Reset
      include Command::Role

      class << self
        def say(message)
          $stdout.puts message
        end

        def err(message)
          $stderr.puts message
        end

        def helper
          @helper ||= Helper.new
        end

        def configure(path, section)
          file = if path.nil?
            [
              "#{ENV["HOME"]}/.crowbarrc",
              "/etc/crowbarrc"
            ].detect do |temp|
              File.exist? temp
            end
          else
            path
          end

          begin
            ini = IniFile.load(file)

            if ini[section]
              ini[section].with_indifferent_access
            else
              {}
            end
          rescue
            {}
          end
        end
      end
    end
  end
end
