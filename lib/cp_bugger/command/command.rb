module CPBugger
  module Command
    class Command
      attr_reader :name
      attr_reader :help
      def initialize(name, &blk)
        @name = name
        @params = []
        instance_eval &blk
      end
      
      def help(str)
        @help = str
      end

      def param(name)
        @params << name
      end

      def execute(&blk)
        @body = blk
      end
      
      def run(target, *args)
        target.instance_eval(*args, &@body)
      end

      def inspect
        "#<CPBugger::Command::Command:#{inspect_id} NAME:#{name}>"
      end

      def to_s
        "#{name}\t\t#{help}"
      end

      def ==(other)
        case other
        when String
          other.to_sym == name
        when Symbol
          other == name
        else
          super
        end
      end
    end
  end
end
