command :new_task do
  help <<-EOL
    create a new task
  EOL
  param :title
  execute do
    new_task
    @task.title = @title
  end
end
