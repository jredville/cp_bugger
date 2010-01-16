module CPBugger
  module Command
    class CommandLoader
      def self.load_commands
        command_path = File.expand_path(File.dirname(__FILE__) + "/../../commands")
        load_path command_path
        extension_path = File.expand_path(File.dirname(__FILE__) + "/../../extensions") 
        load_path extension_path
      end

      def self.load_path(path)
        Dir.chdir path do
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
