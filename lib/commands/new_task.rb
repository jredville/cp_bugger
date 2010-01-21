command :new_task do
  help <<-EOL
    create a new task
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_task
    @bug.title = @title
    tfs_prompt :status
    tfs_prompt :impact
    tfs_prompt :release
    tfs_prompt :component
    tfs_prompt :assigned_to
    @bug.description = extended_prompt :description
    save_bug
  end
end
