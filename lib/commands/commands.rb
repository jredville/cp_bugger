command :commands do
  help <<-EOL
    List all commands
  EOL
  execute do
    all_commands.each do |command|
      puts
    end
  end
end
