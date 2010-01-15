require File.dirname(__FILE__) + "/../spec_helper"
require 'tfs'

describe TFS::Connection do
  before :each do
    NetworkCredential.stub!(:new).and_return(mock("netcred"))
    @tfs = mock("mock_serv", :null_object => true)    
    TeamFoundationServer.stub!(:new).and_return(@tfs)
    @url = "url"
    @user = "user"
    @project = "project"
    @args = [@url,@user,"password",@project]
  end

  it "should not connect when instantiated" do
    TeamFoundationServer.should_not_receive(:new)
    TFS::Connection.new(*@args)
  end
  describe "once created" do
    before :each do
      @con = TFS::Connection.new(*@args)
    end
    
    it "should store the url" do
      @con.url.should == @url
    end
    
    it "should store the user" do
      @con.user.should == @user
    end

    it "should store the project" do
      @con.project.should == @project
    end

    it "should be able to connect" do
      @con.connect
      @con.store.should == @tfs
    end

    it "should have the fully qualified class name in the inspect string" do
      @con.inspect.should match(/TFS::Connection/)
    end

    it "should have the url in the inspect string" do
      @con.inspect.should match(/URL:#{@url}/)
    end

    it "should have the project in the inspect string" do
      @con.inspect.should match(/PROJECT:#{@project}/)
    end
    
    describe "and connected" do
      before :each do
        @con.connect
        @project_mock = mock("project", :null_object => true, :name => @project)
        @workitem = mock("workitem")
        @tfs.stub!(:projects).and_return(@project_mock)
        TFS::Project.stub!(:new).and_return(@project_mock)
      end

      it "should return the TFS project" do
        TFS::Project.should_receive(:new).with(@project_mock).and_return(@project_mock)
        @con.tfs_project.should == @project_mock
      end
      
      it "should create a new workitem" do
        TFS::WorkItem.should_receive(:new).with(@project_mock).and_return(@workitem)
        @workitem.should_receive(:create).and_return(@workitem)
        @con.new_work_item.should == @workitem
      end

      it "should get an existing workitem" do
        @tfs.should_receive(:get_work_item).with(1).and_return(@workitem)
        TFS::WorkItem.should_receive(:new).with(@project_mock, @workitem).and_return(@workitem)
        @workitem.should_not_receive(:create)
        @con.get_work_item(1).should == @workitem
      end
    end
  end
end
