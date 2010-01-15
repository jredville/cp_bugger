help <<-EOL
  List all commands
EOL
command :commands do
  all_commands.each do |command|
    puts
  end
end
