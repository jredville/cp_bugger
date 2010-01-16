command :commands do
  help <<-EOL
    List all commands
  EOL
  execute do
    all_commands.each do |command|
      puts command.to_s
    end
  end
end
