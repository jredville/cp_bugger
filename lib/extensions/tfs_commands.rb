puts "disabled #{__FILE__} #{__LINE__}"
#require File.dirname(__FILE__) + "/../tfs"

module TFSExtensions
  def new_bug
    text = "test"
    class << text
      def title=(val)
        #noop, this is a hack
      end
    end
    instance_variable_set :bug.to_ivar, text
  end
end
