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

module Crowbar
  module Client
    module App
      #
      # A Thor based CLI wrapper for batch commands
      #
      class Database < Base
        desc "create",
          "Create a new Crowbar database"

        long_desc <<-LONGDESC
          `create` will set up a new Crowbar database before Crowbar installation.
          This command only works if Crowbar is not yet installed.
        LONGDESC

        method_option :db_username,
          type: :string,
          default: "crowbar",
          banner: "<db_username>",
          desc: "Username for the Crowbar database user
                                   Min length: 4
                                   Max length: 63
                                   Only alphanumeric characters and/or underscores
                                   Must begin with a letter [a-zA-Z] or underscore"

        method_option :db_password,
          type: :string,
          default: "crowbar",
          banner: "<db_password>",
          desc: "Password for the Crowbar database password
                                   Min length: 4
                                   Max length: 63
                                   Alphanumeric and special characters
                                   Must begin with any alphanumeric character or underscore"

        #
        # Database create command
        #
        # it will set up a new Crowbar database before Crowbar installation.
        # This command only works if Crowbar is not yet installed.
        #
        # @return [String] a formatted response from the server
        #
        def create
          Command::Database::Create.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "connect",
          "Connect to a remote Crowbar database"

        long_desc <<-LONGDESC
          `connect` will connect to a remote Crowbar database before Crowbar installation.
          This command only works if Crowbar is not yet installed.
        LONGDESC

        method_option :db_username,
          type: :string,
          default: "crowbar",
          banner: "<db_username>",
          desc: "Username for the Crowbar database user
                                   Min length: 4
                                   Max length: 63
                                   Only alphanumeric characters and/or underscores
                                   Must begin with a letter [a-zA-Z] or underscore"

        method_option :db_password,
          type: :string,
          default: "crowbar",
          banner: "<db_password>",
          desc: "Password for the Crowbar database password
                                   Min length: 4
                                   Max length: 63
                                   Alphanumeric and special characters
                                   Must begin with any alphanumeric character or underscore"

        method_option :database,
          type: :string,
          default: "crowbar_production",
          banner: "<database>",
          desc: "Name of the Crowbar database
                                   Min length: 4
                                   Max length: 63
                                   Alphanumeric characters and underscores
                                   Must begin with any alphanumeric character or underscore"

        method_option :host,
          type: :string,
          default: "localhost",
          banner: "<host>",
          desc: "Host of the Crowbar database
                                   Min length: 4
                                   Max length: 253
                                   Numbers and period characters (only IPv4)
                                   Hostnames/FQDNs:
                                     alphanumeric characters, hyphens and dots
                                     cannot start/end with digits or hyphen"

        method_option :port,
          type: :string,
          default: "5432",
          banner: "<port>",
          desc: "Port of the Crowbar database
                                   Min length: 1
                                   Max length: 5
                                   Only numbers"

        #
        # Database connect command
        #
        # it will connect to a remote Crowbar database before Crowbar installation.
        # This command only works if Crowbar is not yet installed.
        #
        # @return [String] a formatted response from the server
        #
        def connect
          Command::Database::Connect.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "test",
          "Test the connection to a remote Crowbar database"

        long_desc <<-LONGDESC
          `test` will test the connection to a remote Crowbar database before Crowbar installation.
          This command only works if Crowbar is not yet installed.
        LONGDESC

        method_option :db_username,
          type: :string,
          default: "crowbar",
          banner: "<db_username>",
          desc: "Username for the Crowbar database user
                                   Min length: 4
                                   Max length: 63
                                   Only alphanumeric characters and/or underscores
                                   Must begin with a letter [a-zA-Z] or underscore"

        method_option :db_password,
          type: :string,
          default: "crowbar",
          banner: "<db_password>",
          desc: "Password for the Crowbar database password
                                   Min length: 4
                                   Max length: 63
                                   Alphanumeric and special characters
                                   Must begin with any alphanumeric character or underscore"

        method_option :database,
          type: :string,
          default: "crowbar_production",
          banner: "<database>",
          desc: "Name of the Crowbar database
                                   Min length: 4
                                   Max length: 63
                                   Alphanumeric characters and underscores
                                   Must begin with any alphanumeric character or underscore"

        method_option :host,
          type: :string,
          default: "localhost",
          banner: "<host>",
          desc: "Host of the Crowbar database
                                   Min length: 4
                                   Max length: 253
                                   Numbers and period characters (only IPv4)
                                   Hostnames/FQDNs:
                                     alphanumeric characters, hyphens and dots
                                     cannot start/end with digits or hyphen"

        method_option :port,
          type: :string,
          default: "5432",
          banner: "<port>",
          desc: "Port of the Crowbar database
                                   Min length: 1
                                   Max length: 5
                                   Only numbers"

        #
        # Database test command
        #
        # it will test the connection to a remote Crowbar database before Crowbar installation.
        # This command only works if Crowbar is not yet installed.
        #
        # @return [String] a formatted response from the server
        #
        def test
          Command::Database::Test.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
