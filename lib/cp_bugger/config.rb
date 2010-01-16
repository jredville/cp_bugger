require 'singleton'
require 'yaml'

module CPBugger
  class Config
    include Singleton
    class << self
      def paths
        root_dir = File.expand_path(File.dirname(__FILE__) + "/../../")
        ["~", "~\\cp_bugger", "~\\.cp_bugger", root_dir, "."].map do |path|
          File.expand_path(path)
        end
      end
      
      def method_missing(meth, *args, &blk)
        instance.send(meth, *args, &blk)
      end

      def config
        config_file = "cp_bugger.yaml"
        
        path = paths.select do |dir|
          test_path = File.join(dir, config_file)
          File.exists? test_path
        end[0]
        
        if path
          instance.path = path
        else
          raise ConfigNotFoundError.new
        end
        instance.load
      end
    end

    attr_reader :path
    attr_accessor :url
    attr_accessor :project
    attr_accessor :username

    # write once
    def path=(val)
      @path ||= File.expand_path(val)
    end

    def set_default_path
      @path = File.expand_path("~/cp_bugger.yaml")
    end

    def from_hash(hash)
      self.url = hash[:url]
      self.project = hash[:project]
      self.username = hash[:username]
      @password = hash[:password]
    end

    def to_hash
      {:url => url,
       :project => project,
       :username => username,
       :password => @password}
    end

    def load
      from_hash(YAML.load(@path))
    end

    def store
      puts "Storing config file"
      File.open(@path, "w") {|f| f.puts YAML.dump(to_hash) }
    end
  end

  class ConfigNotFoundError < Exception
    def message
      <<-EOL
        Config file wasn't found in any of the following paths:
        #{Config.paths.map {|path| "- #{path}"}.join("\n")}

        If you need to create a config, run the config command
      EOL
    end
  end
end
