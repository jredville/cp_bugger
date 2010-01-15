module CPBugger
  module Command
    class Command
      attr_reader :name
      attr_reader :help
      def initialize(name, help, &blk)
        @name = name
        @help = help
        @body = blk
      end

      def execute(target, *args)
        target.instance_eval(*args, &blk)
      end

      def inspect
        "#<CPBugger::Command::Command:#{inspect_id} NAME:#{name}>"
      end

      def to_s
        "#{name}\t\t#{help}"
      end
    end
  end
end
