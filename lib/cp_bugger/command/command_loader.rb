module CPBugger
  module Command
    class CommandLoader
      def self.load_commands
        path = File.expand_path(File.dirname(__FILE__) + "/../../commands")
        Dir.chdir(path) do
          Dir["*.rb"].each do |file|
            load_command file
          end
        end
      end

      def self.load_command(path)
        load path
      end
    end
  end
end
