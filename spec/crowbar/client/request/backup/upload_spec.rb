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

describe "Crowbar::Client::Request::Backup::Upload" do
  it_behaves_like "a request class", false do
    subject do
      ::Crowbar::Client::Request::Backup::Upload.new(
        attrs
      )
    end

    let!(:attrs) do
      {
        file: fixture_path(
          "upload.tgz"
        ).open.path
      }
    end

    let!(:params) do
      {
        backup: {
          payload: {
            multipart: true,
            file: fixture_path(
              "upload.tgz"
            ).open.path
          }
        }
      }
    end

    let!(:method) do
      :post
    end

    let!(:url) do
      "api/crowbar/backups/upload"
    end

    let!(:headers) do
      {
        "Accept" => "application/vnd.crowbar.v2.0+json",
        "Content-Length" => "468",
        "Content-Type" => "multipart/form-data; boundary=-----------RubyMultipartPost"
      }
    end
  end
end
