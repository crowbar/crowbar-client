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

require "active_support/concern"

module Crowbar
  module Client
    module Mixin
      #
      # A mixing with formatter related helpers
      #
      module Format
        extend ActiveSupport::Concern

        included do
          def provide_format
            case
            when json?
              options[:format] = :json
            when plain?
              options[:format] = :plain
            when table?
              options[:format] = :table
            end

            if options[:format].nil?
              :table
            else
              options[:format].to_sym
            end
          end

          protected

          def json?
            options[:json]
          end

          def plain?
            options[:plain]
          end

          def table?
            options[:table]
          end
        end
      end
    end
  end
end
