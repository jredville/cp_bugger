module CPBugger
  class Runner
    def self.run
      CPBugger::Config.config
      c = Command::Processor.new
      c.load_commands
      c.process
    end
  end
end
