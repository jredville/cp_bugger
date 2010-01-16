$:.unshift File.dirname(__FILE__)
require 'cp_bugger\repl'
require 'cp_bugger\runner'
require 'cp_bugger\config'

require 'cp_bugger\command'
puts "disabled #{__FILE__} #{__LINE__}"
#require 'tfs'
require 'ext'

def command(name, &blk)
  CPBugger::Command::Command.new(name, &blk)
end
