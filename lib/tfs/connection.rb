module TFS
  class Connection
    attr_accessor :user
    attr_accessor :url
    attr_accessor :project
    attr_accessor :store
    
    def initialize(url, user, password, project)
      @user = user
      @url = url
      @password = password
      @project = project
    end

    def connect
      @store = TeamFoundationServer.new(@url, NetworkCredential.new(@user, @password)).GetService(WIC::WorkItemStore.to_clr_type)
    end

    def tfs_project
      Project.new(@store.projects[@project])
    end

    def new_work_item
      WorkItem.new(tfs_project).create
    end

    def get_work_item(id)
      WorkItem.new(tfs_project, @store.get_work_item(id))
    end

    def inspect
      "#<TFS::Connection:#{inspect_id} URL:#{@url} PROJECT:#{@project}>"
    end
  end
end
