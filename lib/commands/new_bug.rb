command :new_bug do
  help <<-EOL
    Create a new bug
  EOL
  param :title
  execute do
    new_bug
    @bug.title = @title
  end
end
