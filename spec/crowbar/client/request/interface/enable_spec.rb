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

describe "Crowbar::Client::Request::Interface::Enable" do
  it_behaves_like "a request class" do
    subject do
      ::Crowbar::Client::Request::Interface::Enable.new(
        attrs
      )
    end

    let!(:attrs) do
      {
        node: "node1",
        network: "admin",
        proposal: "default"
      }
    end

    let!(:params) do
      {
        name: "node1",
        network: "admin"
      }
    end

    let!(:method) do
      :post
    end

    let!(:url) do
      "crowbar/network/1.0/enable_interface/default"
    end

    let!(:headers) do
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    end
  end
end
