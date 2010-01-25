command :new_bug do
  help <<-EOL
    Create a new bug
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_bug
    edit_bug 
  end
end
