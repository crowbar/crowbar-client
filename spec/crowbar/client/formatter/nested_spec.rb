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

describe "Crowbar::Client::Formatter::Nested" do
  subject { ::Crowbar::Client::Formatter::Nested }

  let!(:values) do
    {
      foo: "Hello1",
      bar: "Hello2",
      baz: "Hello3",
      children: {
        foo: "Works"
      }
    }
  end

  context "with table format" do
    let!(:headings) do
      [
        "Row"
      ]
    end

    let!(:instance) do
      subject.new(
        format: :table,
        values: values,
        headings: headings
      )
    end

    it "returns a terminal table instance" do
      expect(instance.result).to(
        be_kind_of(Terminal::Table)
      )
    end
  end

  context "with plain format" do
    let!(:instance) do
      subject.new(
        format: :plain,
        values: values
      )
    end

    it "returns a plain list" do
      result = <<-EOF.strip_heredoc.strip
        foo Hello1
        bar Hello2
        baz Hello3
        children.foo Works
      EOF

      expect(instance.result).to(
        eq(result)
      )
    end
  end

  context "with json format" do
    let!(:instance) do
      subject.new(
        format: :json,
        values: values
      )
    end

    it "returns valid json" do
      expect(instance.result).to(
        eq(JSON.pretty_generate(values))
      )
    end
  end

  context "with invalid format" do
    it "raises an invalid format error" do
      instance = subject.new(
        format: :foo,
        values: values
      )

      expect do
        instance.result
      end.to(
        raise_error(Crowbar::Client::InvalidFormatError)
      )
    end
  end
end
