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

      def node_action(action, name)
        result = self.class.get(
          "/crowbar/machines/1.0/#{action}/#{name}.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_transition(name, state)
        result = self.class.post(
          "/crowbar/crowbar/1.0/transition/default.json",
          body: { name: name, state: state }
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_rename(name, update)
        result = self.class.post(
          "/crowbar/machines/1.0/rename/#{name}.json",
          body: { alias: update }
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_role(name, update)
        result = self.class.post(
          "/crowbar/machines/1.0/role/#{name}.json",
          body: { role: update }
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_show(name)
        result = self.class.get(
          "/crowbar/machines/1.0/#{name}.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_delete(name)
        result = self.class.delete(
          "/crowbar/machines/1.0/#{name}.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_list
        result = self.class.get(
          "/crowbar/machines/1.0.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def node_status
        result = self.class.get(
          "/nodes/status.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def proposal_action(action, barclamp, proposal)
        result = self.class.get(
          "/crowbar/#{barclamp}/1.0/proposals/#{action}/#{proposal}.json"
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

      def proposal_show(barclamp, proposal)
        result = self.class.get(
          "/crowbar/#{barclamp}/1.0/proposals/#{proposal}.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def proposal_delete(barclamp, proposal)
        result = self.class.delete(
          "/crowbar/#{barclamp}/1.0/proposals/#{proposal}.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def role_list(barclamp)
        result = self.class.get(
          "/crowbar/#{barclamp}/1.0/elements.json"
        )

        if block_given?
          yield result
        else
          result
        end
      end

      def role_show(barclamp, role)
        result = self.class.get(
          "/crowbar/#{barclamp}/1.0/elements/#{role}.json"
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
