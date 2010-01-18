command :new_bug do
  help <<-EOL
    Create a new bug
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_bug
    puts @bug
    edit_work_item
    @bug.description = prompt :description
    @bug.validate
    puts @bug
  end
end
