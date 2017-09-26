#
# Copyright 2017, SUSE
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
      # A mixin with proposal related helpers
      #
      module Proposal
        extend ActiveSupport::Concern

        included do
          protected

          def valid_elements
            # fetch node list
            response = Request::Node::List.new.process
            raise "error fetching node list" unless response.code == 200
            nodes = response.parsed_response["nodes"].map { |node| node["name"] }
            # fetch clusters list
            response = Request::Cluster::List.new.process
            raise "error fetching cluster list" unless response.code == 200
            clusters = response.parsed_response.keys
            nodes + clusters
          end

          def deployment_cleanup(proposal)
            filter = valid_elements
            # filter deployment elements
            proposal["deployment"][args.barclamp]["elements"].each do |role, elements|
              elements.select! { |element| filter.include? element }
            end
            proposal
          end
        end
      end
    end
  end
end
