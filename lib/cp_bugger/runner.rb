module CPBugger
  class Runner
    def self.run
      c = Command::Processor.new
      c.load_commands
      if c.command != :config
        CPBugger::Config.config
      end
      c.process
    end
  end
end
