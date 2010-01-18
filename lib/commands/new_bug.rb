command :new_bug do
  help <<-EOL
    Create a new bug
  EOL
  param :title
  execute do
    extend_with TFSExtensions
    new_bug
    @bug.title = @title
    tfs_prompt :status
    tfs_prompt :impact
    tfs_prompt :release
    tfs_prompt :component
    tfs_prompt :assigned_to
    @bug.description = prompt :description
    save_bug
  end
end
