require 'ftools'

File.copy File.join(directory, 'public', 'flotomatic.js'), File.join(RAILS_ROOT, 'public', 'javascripts', 'flotomatic.js')
File.copy File.join(directory, 'public', 'flotomatic.css'), File.join(RAILS_ROOT, 'public', 'stylesheets', 'flotomatic.css')