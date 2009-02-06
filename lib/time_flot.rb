# Author::    Michael Cowden
# Copyright:: MigraineLiving.com
# License::   Distributed under the same terms as Ruby

class TimeFlot < Flot
  JS_TIME_MULTIPLIER = 1000
  BAR_WIDTH          = 1.day * JS_TIME_MULTIPLIER

  # need a way to replot, do hover overs, etc.

  def initialize(time_axis = :xaxis, &block)
    @options ||= {}
    time_axis(time_axis)
    super(nil, {}, &block)
  end

  def bars(opts = {:show => true, :barWidth => BAR_WIDTH, :align => "center"})
    @options[:bars] = opts
  end
  
	#   series_for "Stress", @journals, :x => :created_on, :y => :stress_rating, :options => `flot options`
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