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
    class Cli
      module Helper
        extend ActiveSupport::Concern

        included do
        end

        module ClassMethods
          def say(message)
            $stdout.puts message
          end

          def err(message)
            $stderr.puts message
          end

          def helper
            @helper ||= Crowbar::Client::Helper.new
          end

          def configure(path, section)
            ini = IniFile.load(detect_config(path))

            if ini[section]
              ini[section].with_indifferent_access
            else
              {}
            end
          rescue
            {}
          end

          protected

          def detect_config(path)
            if path.nil?
              [
                "#{ENV["HOME"]}/.crowbarrc",
                "/etc/crowbarrc"
              ].detect do |temp|
                File.exist? temp
              end
            else
              path
            end
          end
        end
      end
    end
  end
end
