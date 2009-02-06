# Author::    Michael Cowden
# Copyright:: MigraineLiving.com
# License::   Distributed under the same terms as Ruby

=begin rdoc
== TimeFlot

The TimeFlot class provides for a graph of values over time.  See Flot for more details.
=end
class TimeFlot < Flot
  JS_TIME_MULTIPLIER = 1000
  BAR_WIDTH          = 1.day * JS_TIME_MULTIPLIER

  # TODO: need a way to replot, do hover overs, etc.
  # TODO: don't like the way it overrides the initialize method signature
  
  # Create a new TimeFlot object with a default time_axis of :xaxis
  #   TimeFlot.new do |tf|
  #     tf.bars  # default width is equal to 1 day
  #     tf.series_for("Temperature", @temps, :x => :created_on, :y => :temperature)
  #   end
  # 
  def initialize(time_axis = :xaxis, &block)
    @options ||= {}
    time_axis(time_axis)
    super(nil, {}, &block)
  end

  # Sets the default width to one day... different set of defaults from Flot#bar
  #
  def bars(opts = {:show => true, :barWidth => BAR_WIDTH, :align => "center"})
    @options[:bars] = opts
  end
  
  # Sets up a time series based on a collection:
	#   tf.series_for("Temperature", @temps, :x => :created_on, :y => :temperature, :color => '#ff0')
	#
	def series_for(label, collection, opts)
	  if is_time_axis? :xaxis
	    opts[:x] = convert_to_js_time(opts[:x]) #changes the contents of hash passed in
	  else
	    opts[:y] = convert_to_js_time(opts[:y])
    end
	  super label, collection, opts
	end
	
private

  def time_axis(axis = :xaxis)
    [:xaxis, :yaxis].each {|ax| return if is_time_axis?(ax)}
    merge_options axis, {:mode => "time"}
  end
  
  def is_time_axis?(axis)
    options[axis] && (options[axis][:mode] == "time")
  end
  
  def convert_to_js_time(method)
    return method if method.is_a?(Proc)
    lambda {|model|  TimeFlot.js_time_from model.send(method) }
  end
  
  def self.js_time_from(date)
    date.to_time.to_i * JS_TIME_MULTIPLIER
  end
  
  def build_time_series(collection, x, y, x_transform, y_transform)
    collection.map do |model|
      [transform(model, x, x_transform), transform(model, y, y_transform)]
    end
  end
  
  def transform(model, method, transformation)
    transformation ? transformation.call(model.send(method)) : model.send(method)
  end
  
end