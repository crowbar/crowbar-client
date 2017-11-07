#
# Copyright 2016, SUSE Linux GmbH
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

require "easy_diff"

module Crowbar
  module Client
    module Command
      module Database
        #
        # Implementation for the database test command
        #
        class Test < Base
          include Mixin::Database

          def args_with_options
            args.easy_merge!(
              db_username: options.db_username,
              db_password: options.db_password,
              database: options.database,
              host: options.host,
              port: options.port
            )
          end

          def request
            @request ||= Request::Database::Test.new(
              args_with_options
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                say "Successfully tested connection to database"
              else
                err request.parsed_response["error"]
              end
            end
          end
        end
      end
    end
  end
end
