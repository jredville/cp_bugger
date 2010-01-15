require File.dirname(__FILE__) + "/../spec_helper"
require 'tfs'

describe TFS::Node do
  it "wraps a node" do
    node = mock('node')
    TFS::Node.new(node).node.should == node
  end
end
