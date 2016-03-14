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
    module Formatter
      #
      # Base that provides methods shared between different formatters
      #
      class Base
        attr_accessor :options

        def initialize(options = {})
          self.options = options
        end

        def result
          case options[:format].to_sym
          when :table
            process_table
          when :plain
            process_plain
          when :json
            process_json
          else
            raise InvalidFormatError,
              "You requested an invalid format for this resource"
          end
        end

        def empty?
          false
        end
      end
    end
  end
end
