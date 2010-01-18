require File.dirname(__FILE__) + "/../tfs"

module TFSExtensions
  def new_bug
    connect
    @bug = @con.new_work_item
  end

  def new_task
    connect
    @bug = @con.new_work_item
    @bug.type = "Task"
  end

  def connect
    h = CPBugger::Config.instance.to_hash
    @con = TFS::Connection.new(h[:url],h[:username],h[:password],h[:project])
    @con.connect
  end

  def tfs_prompt(var)
    choices = @bug.send("valid_#{var}")
    @bug.send("#{var}=", menu(choices))
  end

  def menu(choices)
    if choices.length == 1
      return choices[0]
    end
    choices.each_with_index do |choice,i|
      puts "#{i+1}\t#{choice.to_s}"
    end
    res = prompt :selection?
    choices[res.to_i - 1]
  end

  def save_bug
    @bug.validate
    puts @bug
    save = menu [:yes, :no]
    if save == :yes
      @bug.save
    end
  end
end
