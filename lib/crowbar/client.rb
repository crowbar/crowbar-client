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

ENV["CURRENT_GEMFILE"] ||= File.expand_path("../../../Gemfile", __FILE__)

if File.exist? ENV["CURRENT_GEMFILE"]
  require "bundler"
  Bundler.setup(:default)
end

require "active_support/all"

module Crowbar
  #
  # Client for the Crowbar API
  #
  module Client
    #
    # Error class that always gets caught by the client
    #
    class SimpleCatchableError < StandardError
    end

    #
    # Error class to catch invalid options
    #
    class BadOptionsError < SimpleCatchableError
    end

    #
    # Error class to catch unsupported formatters
    #
    class BadFormatterError < SimpleCatchableError
    end

    #
    # Error class to catch unsupported filters
    #
    class BadFilterError < SimpleCatchableError
    end

    #
    # Error class to catch invalid formats
    #
    class InvalidFormatError < SimpleCatchableError
    end

    #
    # Error class to catch a closed editor exception
    #
    class EditorAbortError < SimpleCatchableError
    end

    #
    # Error class to catch a editor startup exception
    #
    class EditorStartupError < SimpleCatchableError
    end

    #
    # Error class to catch JSON parsing errors
    #
    class InvalidJsonError < SimpleCatchableError
    end

    #
    # Error class to catch internal server errors
    #
    class InternalServerError < SimpleCatchableError
    end

    #
    # Error class to catch bad gateway responses
    #
    class BadGatewayError < SimpleCatchableError
    end

    #
    # Error class to catch service unavailable responses
    #
    class ServiceUnavailableError < SimpleCatchableError
    end

    #
    # Error class to catch gateway timeout responses
    #
    class GatewayTimeoutError < SimpleCatchableError
    end

    #
    # Error class to catch unauthorized responses
    #
    class NotAuthorizedError < SimpleCatchableError
    end

    #
    # Error class to catch unavailable barclamps
    #
    class UnavailableBarclampError < SimpleCatchableError
      def initialize(barclamp)
        super("Barclamp #{barclamp} is not available")
      end
    end

    #
    # Error class to catch invalid database parameters
    #
    class InvalidDatabaseParameterError < SimpleCatchableError
      def initialize(field)
        super("#{field.capitalize} is not valid. Please check <database subcommand> help")
      end
    end

    autoload :App,
      File.expand_path("../client/app", __FILE__)

    autoload :Command,
      File.expand_path("../client/command", __FILE__)

    autoload :Config,
      File.expand_path("../client/config", __FILE__)

    autoload :Filter,
      File.expand_path("../client/filter", __FILE__)

    autoload :Formatter,
      File.expand_path("../client/formatter", __FILE__)

    autoload :Mixin,
      File.expand_path("../client/mixin", __FILE__)

    autoload :Request,
      File.expand_path("../client/request", __FILE__)

    autoload :Util,
      File.expand_path("../client/util", __FILE__)

    autoload :Version,
      File.expand_path("../client/version", __FILE__)
  end
end
