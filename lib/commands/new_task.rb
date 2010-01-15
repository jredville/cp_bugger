help <<-EOL
  create a new task
EOL
param :title
command :new_task do
  new_task
  @task.title = @title
end
