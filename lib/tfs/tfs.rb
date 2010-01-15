$: << File.join(File.expand_path(ENV['DevEnvDir']), "PrivateAssemblies")
require 'Microsoft.TeamFoundation.Client'
require 'Microsoft.TeamFoundation.WorkItemTracking.Client'
require 'Microsoft.TeamFoundation.VersionControl.Client'
require 'System'
require 'yaml'

include Microsoft::TeamFoundation::Client
include Microsoft::TeamFoundation::VersionControl::Client
include System
include System::Net

WIC = Microsoft::TeamFoundation::WorkItemTracking::Client

require File.dirname(__FILE__) + "/connection.rb"
require File.dirname(__FILE__) + "/work_item.rb"
require File.dirname(__FILE__) + "/project.rb"
require File.dirname(__FILE__) + "/node.rb"
require File.dirname(__FILE__) + "/node_list.rb"

require File.dirname(__FILE__) + "/../ext/object.rb"
