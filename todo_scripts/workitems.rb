require 'codeplex'

def setup
  ait = CodePlex::AdvancedIssueTracker.new
  ait.reset
  ait.type = 'issue'
  ait.sort_by_update_date_dsc
  ait.show_fifty
  ait
end

def run(release)
  ait = setup
  releases = ait.fetch_releases
  if release.nil?
    while true
      puts "> Select release:"
      puts releases.join(', ')
      print '> '
      release = gets.strip
      (puts "Goodbye"; exit(1)) if ['quit', 'exit'].include? release
      break if releases.include? release
      $stderr.puts "> [ERROR] \"#{release}\" is not a valid release, try again"
    end
  end

  puts "> Fetching closed work items from codeplex for #{release} ..."
  #ait.fetch_workitems :type => 'fixed',  :release => release
  ait.fetch_workitems :type => 'closed', :release => release
  puts '> [DONE]'
  
  puts
  puts '=' * 80
  ait.report
  puts '=' * 80
  puts
  
  ait.done
end

if __FILE__ == $0
  run(ARGV[0])
end

