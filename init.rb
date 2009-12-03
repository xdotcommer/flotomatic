require 'flot'
require 'time_flot'
require File.join(directory, 'app', 'helpers', 'flot_helper')

ActionView::Base.send :include, ::FlotHelper