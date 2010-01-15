module TFS
  class AbstractWorkItem
    def self.valid_values(name, lookup_key)
      define_method(name) { @work_item.fields[lookup_key].allowed_values }
    end

    def self.wi_attr(name, key)
      define_method(name) { @work_item.fields[key].value }
      define_method("#{name}=") { |val| @work_item.fields[key].value = val}
    end
    
    attr_reader :work_item
    def initialize(project, work_item = nil)
      @project = project
      @work_item = work_item
    end

    def create
      t = @project.work_item_types['Work Item']
      @work_item = WIC::WorkItem.new(t)
      self
    end

    def attach(path, comment = "no comment needed")
      @work_item.attachments.add(WIC::Attachment.new(path, comment))
    end
  end
  
  class WorkItem < AbstractWorkItem
    valid_values :valid_statuses, "State"
    valid_values :valid_types, "WorkItemType"
    valid_values :valid_impacts, "Code Studio Rank"
    valid_values :valid_assigned_to, "Assigned To"
    valid_values :valid_releases_and_components, "Node Name"  

    wi_attr :type, "WorkItemType"
    wi_attr :status, "State"
    wi_attr :impact, "Code Studio Rank"
    wi_attr :release, "Iteration Path"
    wi_attr :component, "Area Path"
    wi_attr :assigned_to, "Assigned To"

    def validate
      @work_item.validate.map &:name
    end

    def valid_components
      @project.area_nodes
    end

    def valid_releases
      @project.iteration_nodes
    end

    def release=(val)
      @work_item.fields['IterationID'].value = valid_releases.select_node(val).id
    end

    def component=(val)
      @work_item.fields['AreaID'].value = valid_components.select_node(val).id
    end
     
    def attachments
      @work_item.attachments.map &:name
    end

    def inspect
      "#<TFS::WorkItem:#{inspect_id} Project:#{@project.name} Title:#{@work_item.title}>"
    end
    
    def to_s
<<EOL
TITLE: #{title}
#{"="*80}
STATUS: #{status}
TYPE: #{type}
IMPACT: #{impact}
RELEASE: #{release}
ASSIGNED TO: #{assigned_to}
COMPONENT: #{component}
#{"="*80}

DESCRIPTION: #{description}

#{"="*80}
EOL
    end

    def method_missing(meth, *args, &blk)
      @work_item.send(meth, *args, &blk)
    end
  end
end
