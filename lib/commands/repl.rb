#command :repl do
  #command :quit do
    #exit
  #end
  #command_alias :exit, :q, :quit
  #forbid :repl
  
  #repl_loop do
    #get_command
    #process_command
  #end
#end
