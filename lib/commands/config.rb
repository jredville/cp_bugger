command :config do
  help <<-EOL
    Setup the config file for this computer
  EOL
  execute do
    result = {}
    [:url, :project, :username, :password].each do |item|
      result[item] = prompt item
    end
    store_config(result)
  end
end
