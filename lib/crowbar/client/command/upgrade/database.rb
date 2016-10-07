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
      module Upgrade
        #
        # Implementation for the upgrade Database command
        #
        class Database < Base
          include Mixin::Database

          def args_with_options
            args.easy_merge!(
              username: options.db_username,
              password: options.db_password,
              database: options.database,
              host: options.host,
              port: options.port
            )
          end

          def request
            @request ||= Request::Upgrade::Database.new(
              args_with_options
            )
          end

          def execute
            validate_params!(args_with_options)

            request.process do |request|
              unless request.code == 200
                err request.parsed_response["error"]
              end

              response = JSON.parse(request.body)

              steps_with_messages.each do |step, message|
                next if response[step.to_s]["success"]
                err "Failed to #{message}"
              end

              say "Successfully initialized Crowbar"
            end
          end

          protected

          def steps_with_messages
            {
              database_setup: "Setup the Crowbar database",
              database_migration: "Migrate the Crowbar database",
              schema_migration: "Migrate the schemas",
              crowbar_init: "Initialize Crowbar"
            }
          end
        end
      end
    end
  end
end
