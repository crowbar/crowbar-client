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

require "thor"
require "easy_diff"

module Crowbar
  module Client
    module App
      #
      # A base class that provides helper for the wrappers
      #
      class Base < Thor
        #
        # Initialize the Thor command
        #
        # @param args [Array] the arguments
        # @param local_options [Hash] the local options
        # @param config [Hash] the configuration
        # @return [Crowbar::Client::App::Base]
        #
        def initialize(args = [], local_options = {}, config = {})
          super

          Config.configure(
            options.slice(
              :alias,
              :username,
              :password,
              :server,
              :timeout,
              :anonymous,
              :debug
            )
          )
        end

        no_commands do
          include Mixin::Format

          #
          # Print a message to STDOUT
          #
          # @param message [String] the message to print
          #
          def say(message)
            $stdout.puts message
          end

          #
          # Print a message to STDERR
          #
          # @param message [String] the message to print
          # @param exit_code [Integer] the exit code to use
          #
          def err(message, exit_code = nil)
            case provide_format
            when :json
              $stderr.puts JSON.pretty_generate(
                error: message
              )
            else
              $stderr.puts message
            end

            exit(exit_code) unless exit_code.nil?
          end

          #
          # Standard parameters for commands
          #
          # @param args [Hash] the arguments to inject
          # @return [Array]
          #
          def command_params(args = {})
            [
              $stdin,
              $stdout,
              $stderr,
              options,
              args
            ]
          end

          #
          # General errors to catch properly
          #
          # @param error [StandardError] the error to catch
          # @raise [StandardError] only raised if uncatchable
          #
          def catch_errors(error)
            case error
            when SimpleCatchableError
              err error.message, 1
            when Errno::ECONNREFUSED
              err "Connection to server refused", 1
            when SocketError
              err "Unknown server to connect to", 1
            else
              raise error
            end
          end
        end

        class << self
          #
          # Properly print an error on invalid command
          #
          # @param command [String] the command that failed
          # @param error [StandardError] the error class
          # @param args [Array] the arguments that failed
          # @param arity [Integer] the number of arguments
          #
          def handle_argument_error(command, error, args, arity)
            $stderr.puts("Usage: #{banner(command)}")
            exit(2)
          end

          #
          # A banner that gets displayed on help and error
          #
          # @param command [String] the command for help output
          # @param namespace [String] the namespace for help
          # @param subcommand [Bool] the flag if it's a subcommand
          # @return [String]
          #
          def banner(command, namespace = nil, subcommand = true)
            addition = command.formatted_usage(
              self,
              false,
              subcommand
            )

            [
              basename,
              addition
            ].compact.join(" ")
          end
        end
      end
    end
  end
end
