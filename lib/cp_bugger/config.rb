require 'singleton'
require 'yaml'

module CPBugger
  class Config
    class << self
      def paths
        root_dir = File.expand_path(Dir.dirname(__FILE__) + "/../../")
        ["~", "~\\cp_bugger", "~\\.cp_bugger", root_dir, "."].map do |p|
          File.expand_path(p)
        end
      end
      
      def method_missing(meth, *args, &blk)
        instance.send(meth, *args, &blk)
      end

      def config
        config_file = "cp_bugger.yaml"
        
        path = paths.each do |dir|
          test_path = File.join(path, config_file)
          break test_path if File.exists? test_path
        end
        if path
          instance.path = path
        else
          raise ConfigNotFoundError
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
      @path ||= path
    end

    def from_hash(hash)
      self.url = hash[:url]
      self.project = hash[:project]
      self.username = hash[:username]
      self.password = hash[:password]
    end

    def to_hash
      {:url => url,
       :project => project,
       :username => username,
       :password => password}
    end

    def load
      from_hash(YAML.load(@path))
    end

    def store
      YAML.dump(to_hash)
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
