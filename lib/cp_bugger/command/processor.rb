module CPBugger
  module Command
    class Processor
      def load_commands
        CommandLoader.load_commands
      end

      def command
        @command || parse_args
      end

      def parse_args(args = ARGV)
        @command = CommandList.instance[args[0].to_sym].validate(args[1..-1])
      end

      def process
        @command.run(Runner.new)
      end
    end
  end
end
