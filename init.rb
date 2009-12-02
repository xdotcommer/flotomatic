require 'flot'
require 'time_flot'

if RAILS_GEM_VERSION.split('.')[0] == '2' && RAILS_GEM_VERSION.split('.')[1] == '3'
  ActionView::Base.send :include, FlotHelper
else
  $LOAD_PATH << File.join(directory, 'app', 'helpers')
  ActiveSupport::Dependencies.load_paths << File.join(directory, 'app', 'helpers')
end
