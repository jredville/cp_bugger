command :new_task do
  help <<-EOL
    create a new task
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_task
    puts @bug
    edit_work_item
    @bug.description = prompt :description
    @bug.validate
    puts @bug
  end
end
