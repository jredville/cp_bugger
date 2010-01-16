module CPBugger
  module Command
    class CommandList
      include Enumerable
      include Singleton
      def initialize
        @list = []
      end

      def add(item)
        @list << item
      end
      alias_method :<<, :add

      def each(&blk)
        @list.each(&blk)
      end

      def [](val)
        @list.select {|e| e == val}[0]
      end
    end
  end
end
