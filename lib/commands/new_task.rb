command :new_task do
  help <<-EOL
    create a new task
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_task
    edit_bug
  end
end
