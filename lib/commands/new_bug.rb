help <<-EOL
  Create a new bug
EOL
param :title
command :new_bug do
  new_bug
  @bug.title = @title
end
