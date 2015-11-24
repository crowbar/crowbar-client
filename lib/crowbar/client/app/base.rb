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
      class Base < Thor
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
          def say(message)
            $stdout.puts message
          end

          def err(message, exit_code = nil)
            $stderr.puts message
            exit(exit_code) unless exit_code.nil?
          end

          def command_params(args = {})
            [
              $stdin,
              $stdout,
              $stderr,
              options,
              args
            ]
          end
        end
      end
    end
  end
end
