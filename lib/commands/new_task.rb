help <<-EOL
  create a new task
EOL
command :new_task do
  param :title
  new_task
  @task.title = @title
end
