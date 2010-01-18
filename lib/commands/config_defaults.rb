command :config_defaults do
  help <<-EOL
    Setup the bug and task defaults for this computer
  EOL
  execute do
    extend_with TFSExtensions
    @bug = new_work_item(nil)
    result = {}
    result[:bug] = {}
    result[:task] = {}
    [:bug, :task].each do |category|
      [:status, :impact, :release, :component, :assigned_to].each do |item|
        result[category][item] = tfs_prompt item
      end
    end
    store_config(result)
  end
end
