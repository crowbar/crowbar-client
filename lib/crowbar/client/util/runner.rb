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
    module Util
      #
      # A wrapper around the Crowbar CLI for propoer initialization
      #
      class Runner
        attr_accessor :argv
        attr_accessor :stdin
        attr_accessor :stdout
        attr_accessor :stderr
        attr_accessor :kernel

        def initialize(
          argv,
          stdin = STDIN,
          stdout = STDOUT,
          stderr = STDERR,
          kernel = Kernel
        )
          self.argv = argv
          self.stdin = stdin
          self.stdout = stdout
          self.stderr = stderr
          self.kernel = kernel
        end

        def execute!
          exit_code = begin
            $stderr = stderr
            $stdin = stdin
            $stdout = stdout

            App::Entry.start(argv)

            0
          rescue StandardError => e
            b = e.backtrace

            stderr.puts(
              "#{b.shift}: #{e.message} (#{e.class})"
            )

            stderr.puts(
              b.map do |s|
                "\tfrom #{s}"
              end.join("\n")
            )

            1
          rescue SystemExit => e
            e.status
          ensure
            $stderr = STDERR
            $stdin = STDIN
            $stdout = STDOUT
          end

          kernel.exit(exit_code)
        end
      end
    end
  end
end
