require File.dirname(__FILE__) + "/../tfs"
module CPBugger
  class Config
    alias_method :o_from_hash, :from_hash
    def from_hash(hash)
      @bug = hash[:bug]
      @task = hash[:task]
      o_from_hash(hash)
    end

    alias_method :o_to_hash, :to_hash
    def to_hash
      h = o_to_hash
      h.merge! :bug => @bug, :task => @task
      h
    end
  end
end

module System
  class String
    def to_yaml(opts = {})
      YAML.quick_emit(self.object_id, opts) do |out|
        out.map("!ironruby") do |map|
          to_s
        end
      end
    end
  end
end
YAML.add_domain_type("ironruby", "string") do |type, val|
  System::String.new(val)
end

module TFSExtensions
  def new_work_item(type)
    connect
    h = CPBugger::Config.instance.to_hash
    @bug = @con.new_work_item
    if type
      unless h[type]
        puts "Defaults not configured for #{type.to_s}"
        return @bug
      end
      @bug.title = @title
      @bug.status = h[type][:status]
      @bug.impact = h[type][:impact]
      @bug.release = h[type][:release]
      @bug.component = h[type][:component]
      @bug.assigned_to = h[type][:assigned_to]
    end
    @bug
  end

  def edit_work_item
    while(true)
      choices = [:status, :type, :impact, :release, :component, :assigned_to, :quit]
      selection = menu choices
      break if selection == :quit
      tfs_prompt selection
    end
  end

  def new_task
    new_work_item(:task)
    @bug.type = "Task"
  end

  def new_bug
    new_work_item(:bug)
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
  
  def store_config(result)
    h = CPBugger::Config.to_hash
    h[:bug] = result[:bug]
    h[:task] = result[:task]
    CPBugger::Config.from_hash(h)
    CPBugger::Config.store
  end
end
