module TFS
  class Project
    attr_reader :project
    def initialize(project)
      @project = project
      @root_node = root_node
    end

    def area_root_node
      select_node &:is_area_node
    end

    def iteration_root_node
      select_node &:is_iteration_node
    end

    def root_node
      node = @project.area_root_nodes[0]
      while(true)
        if node.name == @project.name
          return Node.new(node)
        else
          node = node.parent_node
        end
      end
    end

    def area_nodes
      NodeList.new(area_root_node)
    end

    def iteration_nodes
      NodeList.new(iteration_root_node)
    end

    def inspect
      "#<TFS::Project:#{inspect_id} Name:#{name}>"
    end

    def method_missing(meth, *args, &blk)
      @project.send(meth, *args, &blk)
    end

    def select_node(&blk)
      n = root_node.child_nodes.select(&blk)[0]
      Node.new(n)
    end
  end
end
