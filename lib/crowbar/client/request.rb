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

require_relative "request/barclamps"
require_relative "request/batch"
require_relative "request/network"
require_relative "request/node"
require_relative "request/proposal"
require_relative "request/reset"
require_relative "request/role"
require_relative "request/repository"

module Crowbar
  module Client
    class Request
      include Singleton
      include HTTParty

      format :json
      attr_accessor :legacy

      def configure(options)
        self.class.base_uri [options[:host], options[:port]].join(":")
        self.class.digest_auth options[:username], options[:password]
        self.class.default_timeout options[:timeout].to_i
        self.class.debug_output $stderr if options[:debug]

        self.legacy = options[:legacy]
      end

      include Barclamps
      include Batch
      include Network
      include Node
      include Proposal
      include Reset
      include Role
      include Repository
    end
  end
end
