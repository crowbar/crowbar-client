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
    module Command
      module Batch
        extend ActiveSupport::Concern

        included do
          desc "Batch specific commands"
          command :batch do |parent|
            parent.desc "Include given proposals"
            parent.flag [:i, :include], type: Array

            parent.desc "Exclude given proposals"
            parent.flag [:e, :exclude], type: Array

            parent.desc "Build proposals from file"
            parent.command :build do |c|
              c.action do |global, opts, args|
                # TODO(must): Implement the batch build functionality
                raise "Not implemented yet!"
              end
            end

            parent.desc "Export proposals to file"
            parent.command :export do |c|
              c.action do |global, opts, args|
                # TODO(must): Implement the batch export functionality
                raise "Not implemented yet!"
              end
            end
          end
        end
      end
    end
  end
end
