command :repl do
  help <<-EOL
    Run a repl-mode command processor
  EOL
  execute do
    command :quit do
      exit
    end
    command_alias :exit, :q, :quit
    forbid :repl
    
    repl_loop do
      get_command
      process_command
    end
  end
end
