help <<-EOL
  Setup the config file for this computer
EOL
command :config do
  result = {}
  [:url, :project, :username, :password].each do |item|
    result[item] = prompt item
  end
  store_config(result)
end
