require File.dirname(__FILE__) + "/../spec_helper"
require 'cp_bugger'

describe CPBugger::Runner do
  it "creates a command runner and runs the commands" do
    @cmd = mock("commands")
    CPBugger::Command::Processor.should_receive(:new).and_return(@cmd)
    @cmd.should_receive(:load_commands)
    @cmd.should_receive(:command).and_return(:test)
    CPBugger::Config.should_not_receive(:config)
    @cmd.should_receive(:process)
    CPBugger::Runner.run
  end
  
  it "creates a command runner and runs the commands" do
    @cmd = mock("commands")
    CPBugger::Command::Processor.should_receive(:new).and_return(@cmd)
    @cmd.should_receive(:load_commands)
    @cmd.should_receive(:command).and_return(:config)
    CPBugger::Config.should_receive(:config)
    @cmd.should_receive(:process)
    CPBugger::Runner.run
  end
end
