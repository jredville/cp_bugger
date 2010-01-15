require 'optparse'
require 'singleton'

module CPBugger
  class Options
    include Singleton
    attr_accessor :url
    attr_accessor :user
    attr_accessor :password
    attr_accessor :project

    def cp_config
      {:url => url,
       :user => user,
       :password => password,
       :project => project
      }
    end
  end
end
