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
    class Request
      include HTTParty
      format :json

      def initialize(options)
        self.class.base_uri [options[:host], options[:port]].join(":")
        self.class.digest_auth options[:username], options[:password]
        self.class.default_timeout options[:timeout].to_i
        self.class.debug_output $stderr if options[:debug]
      end

      def machine_action(action, name)
        result = self.class.get(
          "/crowbar/machines/1.0/#{action}/#{name}"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_rename(name, update)
        result = self.class.post(
          "/crowbar/machines/1.0/rename/#{name}",
          body: { alias: update }
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_role(name, update)
        result = self.class.post(
          "/crowbar/machines/1.0/role/#{name}",
          body: { role: update }
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_show(name)
        result = self.class.get(
          "/crowbar/machines/1.0/#{name}"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_delete(name)
        result = self.class.delete(
          "/crowbar/machines/1.0/#{name}"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_list
        result = self.class.get(
          "/crowbar/machines/1.0"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def machine_status
        # TODO(must): Set the correct route
        result = self.class.get(
          "/crowbar/machines/1.0"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def proposal_list(barclamp)
        result = self.class.get(
          "/crowbar/#{barclamp}/1.0/proposals.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def barclamp_list
        result = self.class.get(
          "/crowbar.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end
    end
  end
end
