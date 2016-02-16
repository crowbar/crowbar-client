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
  module Client
    class SimpleCatchableError < StandardError
    end

    class BadOptionsError < SimpleCatchableError
    end

    class BadFormatterError < SimpleCatchableError
    end

    class BadFilterError < SimpleCatchableError
    end

    class InvalidFormatError < SimpleCatchableError
    end

    class EditorAbortError < SimpleCatchableError
    end

    class EditorStartupError < SimpleCatchableError
    end

    class InvalidJsonError < SimpleCatchableError
    end

    class InternalServerError < SimpleCatchableError
    end

    class BadGatewayError < SimpleCatchableError
    end

    class ServiceUnavailableError < SimpleCatchableError
    end

    class GatewayTimeoutError < SimpleCatchableError
    end

    class NotAuthorizedError < SimpleCatchableError
    end

    class UnavailableBarclampError < SimpleCatchableError
      def initialize(barclamp)
        super("Barclamp #{barclamp} is not available")
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
