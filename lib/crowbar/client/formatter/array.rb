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

require "terminal-table"

module Crowbar
  module Client
    module Formatter
      class Array < Base
        def result
          case options[:format].to_sym
          when :table
            Terminal::Table.new(
              headings: options[:headings],
              rows: options[:values].zip
            )
          when :plain
            options[:values].join("\n")
          when :json
            JSON.pretty_generate(
              options[:values]
            )
          else
            raise InvalidFormatError,
              "Invalid format, valid formats: table, json, plain"
          end
        end

        def empty?
          options[:values].empty?
        end
      end
    end
  end
end
