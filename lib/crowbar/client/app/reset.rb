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
    module App
      class Reset < Base
        desc "proposal BARCLAMP [PROPOSAL]",
          "Reset specific proposal"

        long_desc <<-LONGDESC
          `proposal BARCLAMP [PROPOSAL]` will try to reset the state
          for the specified barclamp or optional proposal.
        LONGDESC

        def proposal(barclamp, proposal = nil)
          Command::Reset::Proposal.new(
            *command_params(
              barclamp: barclamp,
              proposal: proposal
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "nodes",
          "Reset all nodes state"

        long_desc <<-LONGDESC
          `nodes` will try to reset the state of all known nodes within
          the cluster.
        LONGDESC

        def nodes
          Command::Reset::Nodes.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
