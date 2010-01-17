module CPBugger
  module Command
    class Runner
      def all_commands
        CommandList.instance
      end

      def prompt(name)
        print "#{name}>> "
        gets
      end

      def store_config(result)
        Config.set_default_path
        Config.from_hash(result)
        Config.store
      end

      def extend_with(mod)
        extend mod
      end

      def repl_loop(&blk)
        
      end
    end
  end
end
