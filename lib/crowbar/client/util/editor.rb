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

require "tempfile"
require "json"

module Crowbar
  module Client
    module Util
      class Editor
        attr_accessor :content
        attr_accessor :options

        def initialize(options = {})
          self.options = options
        end

        def result
          case options.fetch(:format, :json)
          when :json
            begin
              JSON.load content
            rescue JSON::ParserError
              raise InvalidJsonError,
                "Failed to parse the JSON"
            end
          else
            raise InvalidFormatError,
              "This format is not supported by the editor"
          end
        end

        def edit!
          file.write formatted
          file.rewind

          original_mtime = File.mtime file.path

          unless start
            raise EditorStartupError,
              "Failed to start a default editor"
          end

          updated_mtime = File.mtime file.path

          unless original_mtime < updated_mtime
            raise EditorAbortError,
              "Closed editor without saving"
          end

          self.content = file.read
          true
        ensure
          file.close
          file.unlink
        end

        protected

        def file
          @file ||= Tempfile.new(
            options.fetch(
              :prefix,
              "editor"
            )
          )
        end

        def formatted
          case options.fetch(:format, :json)
          when :json
            JSON.pretty_generate(
              options.fetch(
                :content,
                {}
              )
            )
          else
            raise InvalidFormatError,
              "This format is not supported by the editor"
          end
        end

        def program
          ENV["EDITOR"] || "vi"
        end

        def start
          command = [
            program,
            file.path
          ].join(" ")

          system(command)
        end
      end
    end
  end
end
