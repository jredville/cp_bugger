module CPBugger
  module Command
    class Command
      attr_reader :name
      attr_reader :validated_params
      def initialize(name, &blk)
        @name = name
        @params = []
        @validated_params = {}
        instance_eval &blk
        CommandList.instance.add(self)
      end
      
      def help(str)
        @help = str.strip.chomp
      end

      def param(name)
        @params << name
      end

      def execute(&blk)
        @body = blk
      end
      
      def run(target)
        @validated_params.each do |name, value|
          target.instance_variable_set(name.to_ivar, value)
        end
        target.instance_eval(&@body)
      end

      def inspect
        "#<CPBugger::Command::Command:#{inspect_id} NAME:#{name}>"
      end

      def to_s
        #TODO: need to figure out the formula for this, i'm blanking
        tabs = case name.to_s.length
               when 0..7
                 4
               when 8..15
                 3
               when 16..23
                 2
               when 24..31
                 1
               else
                 0
               end
        "#{name}#{"\t" * tabs}#{@help}"
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

      def validate(*params)
        @params.zip(params).each do |name, value|
          @validated_params[name] = value or raise ParameterError.new(name)
        end

        self
      end
    end
  end
  
  class ParameterError < Exception
    def initialize(name)
      @name = name
    end

    def message
      "The parameter #{name} must have a value"
    end
  end
end
