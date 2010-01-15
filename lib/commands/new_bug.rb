command :new_bug do
  param :title
  new_bug
  @bug.title = @title
end
