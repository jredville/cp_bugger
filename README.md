# CPBugger #

Currently this is just a library to interface with TFS, particularly
[CodePlex](http://codeplex.com).  It will become a little repl for handling bugs
from CodePlex.

# Requirements #

* [IronRuby](http://github.com/ironruby/ironruby) (Tested with head at this point)
* TFS Dlls (part of the Visual Studio install. Please file a bug if you have
  them installed and it doesn't work)

# Getting Started #

Assuming ir.exe is in your path, you'll need to run `bin\\cp_bugger.bat config` 
to get started. This will ask you for your CodePlex TFS url, your username
(remember to prefix with cp_), your password (stored in plaintext at the moment,
pull requests welcome), and your project name. After that, you can run
`bin\\cp_bugger.bat new_bug "new bugs title"` to create a new bug. CPBugger will allow you to change the fields of the bug.

## Notes ##

### Description ###

_Description_ allows you to write a multiline description that applies to the bug.
To finish the description enter "DONE" on it's own line.

### Attach ###

_Attach_ allows you to attach a file. Enter the path to the file at the prompt.
