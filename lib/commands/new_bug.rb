help <<-EOL
  Create a new bug
EOL
command :new_bug do
  param :title
  new_bug
  @bug.title = @title
end
