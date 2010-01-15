module CPBugger
  class Runner
    def self.run
      c = Command::Processor.new
      c.load
      c.process
    end
  end
end
