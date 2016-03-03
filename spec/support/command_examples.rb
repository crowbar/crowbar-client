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

shared_examples "a command class" do |with_body|
  let!(:superclass_description) do
    self.class.superclass_metadata[:description]
  end

  let(:superclass) do
    superclass_description.gsub(/Command/, "Request").constantize
  end

  it "should always return a request class" do
    expect(subject.request).to(
      be_a(
        superclass
      )
    )
  end

  it "should have options" do
    expect(subject.options).to(
      be_a(
        Hashie::Mash
      )
    )
  end

  it "should have arguments" do
    expect(subject.args).to(
      be_a(
        Hashie::Mash
      )
    )
  end

  it "should have file descriptors" do
    [:stdin, :stdout, :stderr].each do |fd|
      expect(subject.send(fd)).to(
        be_a(
          StringIO
        )
      )
    end
  end
end
