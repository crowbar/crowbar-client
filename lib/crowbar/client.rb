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

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../../Gemfile", __FILE__)

if File.exist? ENV["BUNDLE_GEMFILE"]
  require "bundler"
  Bundler.setup(:default)
else
  gem "activesupport", version: ">= 3.0.0"
  gem "gli", version: ">= 2.13.0"

  gem "inifile", version: ">= 3.0.0"
  gem "httparty", version: ">= 0.13.3"
  gem "terminal-table", version: ">= 1.5.2"
  gem "easy_diff", version: ">= 0.0.5"
  gem "hashie", version: ">= 3.4.1"
end

require "active_support/all"

module Crowbar
  module Client
    class UnavailableBarclampError < StandardError
      def initialize(barclamp)
        super("Barclamp #{barclamp} is not available")
      end
    end

    class BadFormatterError < StandardError
    end

    class BadFilterError < StandardError
    end

    class InvalidFormatError < StandardError
    end

    class EditorAbortError < StandardError
    end

    class EditorStartupError < StandardError
    end

    class InvalidJsonError < StandardError
    end
  end
end

require_relative "client/util"
require_relative "client/filter"
require_relative "client/formatter"
require_relative "client/command"
require_relative "client/helper"
require_relative "client/request"
require_relative "client/version"
require_relative "client/cli"
