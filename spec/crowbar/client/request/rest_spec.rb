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

require_relative "../../../spec_helper"

describe "Crowbar::Client::Request::Rest" do
  subject { ::Crowbar::Client::Request::Rest }

  context "with default parameters" do
    before do
      allow(Crowbar::Client::Config).to receive("server") { "testserver1" }
      allow(Crowbar::Client::Config).to receive("username") { "testuser1" }
      allow(Crowbar::Client::Config).to receive("password") { "testpassword1" }
      allow(Crowbar::Client::Config).to receive("verify_ssl") { true }
    end

    let!(:instance) do
      subject.new
    end

    it "uses root URL from global config" do
      expect(instance.url).to(eq("testserver1/"))
    end

    it "uses user from global config" do
      expect(instance.user).to(eq("testuser1"))
    end

    it "uses password from global config" do
      expect(instance.password).to(eq("testpassword1"))
    end

    it "uses verify_ssl from global config" do
      expect(instance.options[:verify_ssl]).to(eq(true))
    end

    it "uses digest auth_type" do
      expect(instance.options[:auth_type]).to(eq(:digest))
    end
  end

  context "with username/password including reserved characters" do
    let!(:instance) do
      subject.new(
        user: "testuser;/?:@&=+$,[]",
        password: "testpassword;/?:@&=+$,[]"
      )
    end

    it "escapes the username" do
      expect(instance.user).to(
        eq("testuser%3B%2F%3F%3A%40%26%3D%2B%24%2C%5B%5D")
      )
    end

    it "escapes the password" do
      expect(instance.password).to(
        eq("testpassword%3B%2F%3F%3A%40%26%3D%2B%24%2C%5B%5D")
      )
    end
  end

end
