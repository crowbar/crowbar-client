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

require_relative "../../../../spec_helper"

describe "Crowbar::Client::Command::Backup::Upload" do
  include_context "command_context"

  it_behaves_like "a command class", true do
    subject do
      ::Crowbar::Client::Command::Backup::Upload.new(
        stdin,
        stdout,
        stderr,
        {},
        file: fixture_path(
          "upload.tgz"
        )
      )
    end
  end
  context "Using a nonexistant file" do
    it "should show an error message" do
      expect do
        Crowbar::Client::Command::Backup::Upload.new(
          stdin,
          stdout,
          stderr,
          {},
          file: "test"
        ).request
      end.to raise_error(Crowbar::Client::SimpleCatchableError, "File test does not exist.")
    end
  end

  context "Using a existing file" do
    it "should NOT show an error message" do
      expect do
        Crowbar::Client::Command::Backup::Upload.new(
          stdin,
          stdout,
          stderr,
          {},
          file: fixture_path(
            "upload.tgz"
          )
        ).request
      end.not_to raise_error
    end
  end
end
