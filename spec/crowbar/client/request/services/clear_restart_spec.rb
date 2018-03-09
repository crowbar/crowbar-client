#
# Copyright 2017, SUSE Linux GmbH
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

header = "application/vnd.crowbar.v2.0+json"

describe "Crowbar::Client::Request::Services::ClearServiceRestart" do
  it_behaves_like "a request class", true do
    subject do
      ::Crowbar::Client::Request::Services::ClearServiceRestart.new(
        attrs
      )
    end

    let!(:attrs) { { node: "test", cookbook: "test", service: "test" } }
    let!(:params) { { node: "test", cookbook: "test", service: "test" } }
    let!(:method) { :post }
    let!(:url) { "api/restart_management/restarts" }
    let!(:headers) { { "Accept" => header, "Content-Type" => header } }
  end
end
