module CPBugger
  module Command
    class Processor
      attr_reader :args
      def initialize
        @args = ARGV
      end

      def load_commands
        CommandLoader.load_commands
      end

      def command
        
      end

      def process
        
      end
    end
  end
end
