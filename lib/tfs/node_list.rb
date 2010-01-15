module TFS
  class NodeList
    include Enumerable
    
    attr_accessor :root
    attr_accessor :list
    def initialize(node)
      @root = node
      @list = build_list(@root)
    end

    def build_list(node, list = [])
      list << node
      children = node.children
      if children.empty?
        list
      else
        children.each do |child|
          list = build_list(child, list)
        end
      end
      list
    end

    def each
      @list.each do |item|
        yield item
      end
    end

    def select_node(val)
      node = list.select {|e| e.name == val}[0]
      node or raise NodeNotFoundError.new
    end

    def inspect
      "#<TFS::NodeList:#{inspect_id} ROOT:#{@root}>"
    end
  end

  class NodeNotFoundError < Exception
    def message
      "The requested node was not found"
    end
  end
end
