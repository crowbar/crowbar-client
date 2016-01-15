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

describe "Crowbar::Client::Command::Proposal::Create" do
  include_context "command_context"

  subject do
    ::Crowbar::Client::Command::Proposal::Create.new(
      stdin,
      stdout,
      stderr
    )
  end

  it "should always return a request class" do
    subject.args[:barclamp] = "testing"

    subject.options[:merge] = true
    subject.options[:data] = "{}"

    stub_request(:get, "http://crowbar/crowbar/testing/1.0/proposals/template")
      .with(
        headers: {
          "Accept" => "application/json",
          "Content-Type" => "application/json"
        }
      )
      .to_return(
        status: 200,
        body: "{}",
        headers: {}
      )

    expect(subject.request).to(
      be_a(
        ::Crowbar::Client::Request::Proposal::Create
      )
    )
  end

  pending
end
