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
require "json"

module Crowbar
  module Client
    module Formatter
      #
      # Formatter to properly print out keys and values in different formats
      #
      class Nested < Base
        def empty?
          options[:values].blank?
        end

        protected

        def process_table
          case
          when options[:values].is_a?(::Hash)
            values = process_hash(
              options[:values],
              options[:path],
              :table
            )
          when options[:values].is_a?(::Array)
            values = [[
              options[:path],
              options[:values].join("\n")
            ]]
          else
            values = [[
              options[:path],
              options[:values]
            ]]
          end

          Terminal::Table.new(
            headings: options[:headings],
            rows: values
          )
        end

        def process_plain
          case
          when options[:values].is_a?(::Hash)
            values = process_hash(
              options[:values],
              options[:path],
              :plain
            )
          when options[:values].is_a?(::Array)
            values = [].tap do |result|
              options[:values].each_with_index do |row, index|
                result.push [
                  [options[:path], index].join("."),
                  row
                ]
              end
            end
          else
            values = [[
              options[:path],
              options[:values]
            ]]
          end

          values.map do |value|
            value.join(" ")
          end.join("\n")
        end

        def process_json
          if options[:values].is_a?(::Hash) || options[:values].is_a?(::Array)
            JSON.pretty_generate(
              options[:values]
            )
          else
            options[:values]
          end
        end

        def process_hash(values, path = "", type = :table)
          [].tap do |result|
            values.map do |key, value|
              new_path = [path.to_s.dup, key].reject(&:empty?).join(".")

              case
              when value.is_a?(::Hash)
                result.concat process_hash(
                  value,
                  new_path,
                  type
                )
              when value.is_a?(::Array)
                case type
                when :table
                  result.push [
                    new_path,
                    value.join("\n")
                  ]
                when :plain
                  value.each_with_index do |row, index|
                    result.push [
                      [new_path, index].join("."),
                      row
                    ]
                  end
                end
              else
                result.push [
                  new_path,
                  value
                ]
              end
            end
          end
        end
      end
    end
  end
end
