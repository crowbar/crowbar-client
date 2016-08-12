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

shared_examples "a request class" do |with_body|
  before(:each) do
    Crowbar::Client::Config.configure(
      Crowbar::Client::Config.defaults.merge(
        server: "http://crowbar:80"
      )
    )
  end

  it "provides a method value" do
    expect(subject.method).to(
      eq(method)
    )
  end

  it "provides a specific url" do
    expect(subject.url).to(
      eq(url)
    )
  end

  it "provides a valid payload" do
    expect(subject.content).to(
      eq(params)
    )
  end

  it "submits payload to an API" do
    content = if with_body
      params
    else
      ""
    end

    allow(Crowbar::Client::Request::Rest).to receive(:new).and_return(
      Crowbar::Client::Request::Rest.new(
        url: url,
        auth_type: nil
      )
    )

    stub_request(
      method,
      "http://crowbar:80/#{url}"
    ).to_return(
      status: 200,
      body: "",
      headers: {}
    )

    subject.process

    expect(
      Crowbar::Client::Request::Rest.new(url: url).send(
        method,
        content
      ).code
    ).to eq(200)
  end
end
