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
      module Backup
        #
        # Implementation for the backup download command
        #
        class Download < Base
          def request
            @request ||= Request::Backup::Download.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                if write(request.body)
                  say "Successfully downloaded backup"
                else
                  err "Failed to download backup"
                end
              when 404
                err "Backup does not exist"
              else
                err request.body
              end
            end
          end

          protected

          def write(body)
            path.binmode
            path.write body

            true
          rescue
            path.unlink if path.file?
            false
          end

          def path
            @path ||=
              case args.file
              when "-"
                stdout.to_io
              when File
                args.file
              else
                File.new(
                  args.file || "#{args.name}.tar.gz",
                  File::CREAT | File::TRUNC | File::RDWR
                )
              end
          end
        end
      end
    end
  end
end
