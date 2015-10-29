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

require_relative "../../../spec_helper"

describe "Crowbar::Client::Filter::Array" do
  subject { ::Crowbar::Client::Filter::Array }

  let!(:values) do
    [
      "row1",
      "row2",
      "row3"
    ]
  end

  context "with a defined filter" do
    it "limits the array output" do
      instance = subject.new(
        values: values,
        filter: "row1"
      )

      expect(
        instance.result
      ).to eq([values[0]])
    end

    it "returns an empty array" do
      instance = subject.new(
        values: values,
        filter: "nothing"
      )

      expect(
        instance.result
      ).to eq([])
    end
  end

  context "without defined filter" do
    it "returns unfiltered values" do
      instance = subject.new(
        values: values
      )

      expect(
        instance.result
      ).to eq(values)
    end
  end
end
