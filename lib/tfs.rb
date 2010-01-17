$: << File.join(File.expand_path(ENV['DevEnvDir']), "PrivateAssemblies")
$: << File.join(File.expand_path(ENV['DevEnvDir']), "ReferenceAssemblies", "v2.0")
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

require File.dirname(__FILE__) + "/tfs/connection"
require File.dirname(__FILE__) + "/tfs/work_item"
require File.dirname(__FILE__) + "/tfs/project"
require File.dirname(__FILE__) + "/tfs/node"
require File.dirname(__FILE__) + "/tfs/node_list"

require File.dirname(__FILE__) + "/ext"
