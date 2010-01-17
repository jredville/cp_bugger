command :new_task do
  help <<-EOL
    create a new task
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_task
    @task.title = @title
    tfs_prompt :status
    tfs_prompt :impact
    tfs_prompt :release
    tfs_prompt :component
    tfs_prompt :assigned_to
    @bug.description = prompt :description
    @bug.validate
    puts @bug
  end
end
