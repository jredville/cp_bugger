module TFS
  class Node
    attr_reader :node
    def initialize(node)
      @node = node
    end
    
    def area?
      @node.is_area_node
    end

    def iteration?
      @node.is_iteration_node
    end

    def parent
      Node.new(@node.parent_node)
    end

    def children
      @node.child_nodes.map {|n| Node.new(n)}
    end

    def type
      if area?
        "area"
      elsif iteration?
        "iteration"
      else
        "root"
      end
    end

    def id
      @node.id
    end

    def inspect
      "#<TFS::Node:#{inspect_id} Name:#{name} Type:#{type}>"
    end

    def method_missing(meth, *args, &blk)
      @node.send(meth, *args, &blk)
    end
  end
end
