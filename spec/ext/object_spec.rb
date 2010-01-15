require File.dirname(__FILE__) + '/../spec_helper'
require 'ext/object'

describe "Object extensions" do
  describe "inspect_id" do
    it "returns a string" do
      Object.new.inspect_id.should be_kind_of(String)
    end

    it "returns the object_id * 2 in hex" do
      o = Object.new
      expected_id = o.object_id * 2
      expected = /0x0.+#{expected_id.to_s(16)}/
      o.inspect_id.should match(expected)
    end
  end
end
