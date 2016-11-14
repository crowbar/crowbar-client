#
# Copyright 2016, SUSE Linux GmbH
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

describe "Crowbar::Client::Request::Database::Create" do
  it_behaves_like "a request class", true do
    subject do
      ::Crowbar::Client::Request::Database::Create.new(
        attrs
      )
    end

    let!(:attrs) do
      {
        db_username: "crowbar",
        db_password: "crowbar"
      }
    end

    let!(:params) do
      {
        username: "crowbar",
        password: "crowbar"
      }
    end

    let!(:method) do
      :post
    end

    let!(:url) do
      "api/database/new"
    end

    let!(:headers) do
      {
        "Content-Type" => "application/vnd.crowbar.v2.0+json",
        "Accept" => "application/vnd.crowbar.v2.0+json"
      }
    end
  end
end
