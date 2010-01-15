require File.dirname(__FILE__) + '/../spec_helper'
require 'ext/symbol'

describe "Symbol extensions" do
  describe "to_proc" do
    it "allows a symbol to be a proc" do
      :a.to_proc.should be_kind_of(Proc)
    end

    it "sends itself to the argument passed into it's block" do
      a = mock('object')
      a.should_receive(:a)
      [a].each(&:a)
    end
  end
end
