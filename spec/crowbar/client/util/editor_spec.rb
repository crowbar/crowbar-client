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

describe "Crowbar::Client::Util::Editor" do
  subject { ::Crowbar::Client::Util::Editor }

  let!(:file) do
    Tempfile.new("editor")
  end

  before :each do
    allow_any_instance_of(subject).to(
      receive(:file).and_return(file)
    )
  end

  context "when calling editor" do
    context "from unknown env variable" do
      it "tries to start an editor" do
        ENV["EDITOR"] = nil

        expect_any_instance_of(subject).to(
          receive(:system)
            .with("vi", file.path)
            .and_return(true)
        )

        expect do
          subject.new.edit!
        end.to(
          raise_error(Crowbar::Client::EditorAbortError)
        )
      end
    end

    context "from specific env variable" do
      it "tries to start an editor" do
        ENV["EDITOR"] = "nano"

        expect_any_instance_of(subject).to(
          receive(:system)
            .with(ENV["EDITOR"], file.path)
            .and_return(true)
        )

        expect do
          subject.new.edit!
        end.to(
          raise_error(Crowbar::Client::EditorAbortError)
        )
      end
    end
  end

  context "with json format" do
    context "while getting the result" do
      it "returns a hash" do
        instance = subject.new(format: :json)
        instance.content = "{}"

        expect(
          instance.result
        ).to eq({})
      end

      it "raises an error on bad content" do
        instance = subject.new(format: :json)
        instance.content = "foo"

        expect do
          instance.result
        end.to(
          raise_error(Crowbar::Client::InvalidJsonError)
        )
      end
    end
  end

  context "with invalid format" do
    context "while getting the result" do
      it "raises an invalid format error" do
        instance = subject.new(format: :foo)
        instance.content = "{}"

        expect do
          instance.result
        end.to(
          raise_error(Crowbar::Client::InvalidFormatError)
        )
      end
    end
  end
end
