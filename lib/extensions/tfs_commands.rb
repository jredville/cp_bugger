require File.dirname(__FILE__) + "/../tfs"

module TFSExtensions
  def new_bug
    connect
    @bug = @con.new_work_item
    @bug.title = @title
  end

  def new_task
    connect
    @bug = @con.new_work_item
    @bug.type = "Task"
    @bug.title = @title
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
    display_bug
    save = menu [:yes, :no]
    if save == :yes
      @bug.save
    end
  end

  def extended_prompt(type)
    puts type.to_s << ">>"
    res = ""
    done = nil
    while(!done)
      text = gets
      if text.chomp == "DONE"
        done = true
      else
        res << text
      end
    end
    res
  end

  def display_bug
    puts @bug
  end

  def edit_bug
    br = false
    choices = {:status => lambda { tfs_prompt :status},
               :impact => lambda { tfs_prompt :impact},
               :release => lambda { tfs_prompt :release},
               :component => lambda { tfs_prompt :component},
               :assigned_to => lambda { tfs_prompt :assigned_to},
               :title => lambda { tfs_prompt :title},
               :type => lambda { tfs_prompt :type},
               :description => lambda {@bug.description = extended_prompt :description},
               :save => lambda {save_bug;br = true}}
    keys = choices.keys
    while(!br)
      display_bug
      choice = menu keys
      choices[choice].call
    end
  end
end
