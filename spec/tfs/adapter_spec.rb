require File.dirname(__FILE__) + "/../spec_helper"
require 'tfs\tfs'
require 'cp_bugger'
require 'stringio'
require 'yaml'

describe TFS::Adapter do
  before :each do
    @c = "config"
    @config = StringIO.new
    @default = "~\\.cp_buggerrc"
    File.stub!(:expand_path).and_return(@c)
    File.stub!(:open).and_return(@config)
  end

  it "takes a config file parameter" do
    TFS::Adapter.new(@c).config.should == File.expand_path(@c)
  end

  it "defaults the config to '~\\.cp_buggerrc'" do
    File.should_receive(:expand_path).with("~\\.cp_buggerrc").and_return("correct")
    TFS::Adapter.new.config.should == "correct"
  end

  it "writes a config file if one doesn't exist" do
    File.should_receive(:exists?).with(@c).and_return(false)
    File.should_receive(:expand_path).with(@c).and_return(@c)
    File.should_receive(:open).with(@c, "w").and_return(@config)
    TFS::Adapter.new(@c)
  end

  it "fills config file from command line options" do
    options = CPBugger::Options.instance
    options.url = "testurl"
    options.user = "testuser"
    options.password = "testpassword"
    options.project = "project"
    CPBugger::Options.stub!(:instance).and_return(options)
    TFS::Adapter.new(@c)
    expected = StringIO.new
    expected << YAML.dump({:project => "project", :url => "testurl", :user => "testuser", :password => "testpassword"})
    @config.readlines.should == expected.readlines
  end

  it "reads a config file" do
    @config = {:url => "testurl", :user => "testuser", :password => "testpassword", :project => "project"}
    File.should_receive(:exists?).with(@c).and_return(true)
    YAML.should_receive(:load).and_return(@config)
    tfs = TFS::Adapter.new(@c)
    tfs.user.should == @config[:user]
    tfs.url.should == @config[:url]
    tfs.password.should == @config[:password] 
    tfs.project.should == @config[:project]
  end
end
