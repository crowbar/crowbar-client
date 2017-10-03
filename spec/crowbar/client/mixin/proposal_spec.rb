#
# Copyright 2017, SUSE
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

# monkey patch rest-client to make Travis happy
# see: https://build.suse.de/package/view_file/SUSE:SLE-12-SP2:Update:Products:Cloud7:Update/rubygem-rest-client/add-digest-auth.patch?expand=1
module RestClient
  module AbstractResponse
    def parsed_response
      JSON.parse(self.body)
    end
  end
end

class ProposalMock
  include ::Crowbar::Client::Mixin::Proposal
  # expose protected methods
  def test_valid_elements
    valid_elements
  end

  def test_deployment_cleanup(proposal)
    deployment_cleanup proposal
  end

  def test_nodes
    [
      "node1",
      "node2"
    ]
  end

  def test_clusters
    [
      "cluster1",
      "cluster2"
    ]
  end
end

describe "Crowbar::Client::Mixin::Proposal" do
  subject { ProposalMock.new }

  let!(:proposal) do
    {
      "deployment" => {
        "bctest" => {
          "elements" => {
            "role1" => [
              "node1",
              "oldnode1",
              "oldnode2",
              "cluster1",
              "oldcluster1"
            ],
            "role2" => [
              "node2",
              "cluster2"
            ]
          }
        }
      }
    }
  end

  before(:each) do
    allow(subject).to receive_message_chain("args.barclamp") { "bctest" }
  end

  context "without clusters" do
    before(:each) do
      stub_request(:get, "http://crowbar/clusters")
        .with(
          headers: {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          status: 200,
          body: "{}",
          headers: {
            "Content-Type" => "application/json"
          }
        )
      stub_request(:get, "http://crowbar/crowbar/machines/1.0")
        .with(
          headers: {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          status: 200,
          body: '{ "nodes": [{"name":"node1"}, {"name":"node2"}] }',
          headers: {
            "Content-Type" => "application/json"
          }
        )
    end

    it "valid_elements returns only nodes" do
      expect(
        subject.test_valid_elements
      ).to eq(subject.test_nodes)
    end

    it "deployment_cleanup removes all clusters and outdated nodes" do
      clean_proposal = subject.test_deployment_cleanup proposal
      elements = clean_proposal["deployment"]["bctest"]["elements"]
      expect(
        elements["role1"]
      ).to eq(["node1"])
      expect(
        elements["role2"]
      ).to eq(["node2"])
    end
  end

  context "with clusters" do
    before(:each) do
      stub_request(:get, "http://crowbar/clusters")
        .with(
          headers: {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          status: 200,
          body: '{"cluster1":{}, "cluster2":{}}',
          headers: {
            "Content-Type" => "application/json"
          }
        )
      stub_request(:get, "http://crowbar/crowbar/machines/1.0")
        .with(
          headers: {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
          }
        )
        .to_return(
          status: 200,
          body: '{"nodes":[{"name":"node1"},{"name":"node2"}]}',
          headers: {
            "Content-Type" => "application/json"
          }
        )
    end

    it "valid_elements returns nodes and clusters" do
      expect(
        subject.test_valid_elements
      ).to eq(subject.test_nodes + subject.test_clusters)
    end

    it "deployment_cleanup removes outdated clusters and nodes" do
      clean_proposal = subject.test_deployment_cleanup proposal
      elements = clean_proposal["deployment"]["bctest"]["elements"]
      expect(
        elements["role1"]
      ).to eq(["node1", "cluster1"])
      expect(
        elements["role2"]
      ).to eq(["node2", "cluster2"])
    end
  end
end
