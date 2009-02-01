class Flot
  CANVAS_DEFAULT_HTML_OPTIONS = {:style => "height: 300px"}
  attr_accessor :data, :options, :placeholder, :html_options
  alias  :canvas :placeholder
  alias  :canvas= :placeholder=

  #TODO: :tick_formatter => enum / hash or a mapping function
  #     :tick_formatter => {1 => "Mon", 2 => "Tue", ...} OR if an x or y is a string/sym
  #     consider auto conversion --> a TotalFlot? or total_for(@collection, x, y)
  #TODO: define callbacks - set and clear selection, binding plotselected, etc.
  #TODO: custom functions for ticks and such

  def initialize(canvas = nil, html_opts = {})
    @collection_filter = nil
    returning(self) do |flot|
      flot.data       ||= []
      flot.options    ||= {}
      flot.html_options = html_opts.reverse_merge(CANVAS_DEFAULT_HTML_OPTIONS)
      flot.canvas       = canvas if canvas
      yield flot if block_given?
    end
  end

  # flot.[lines|points|bars|legend](opts = {:show => true})
  [:lines, :points, :bars, :legend].each do |meth|
    define_method(meth) do |*args|
      merge_options(meth, arguments_to_options(args))
    end
  end
  
  # So you do stuff like: flot.grid(:color => "#699")
  def method_missing(meth, opts = {})
    merge_options meth, opts
  end

  def filter(&block)
    @collection_filter = block
  end

  def series_for(label, collection, opts)
    series label, map_collection(collection, opts[:x], opts[:y]), opts[:options] || {}
  end
  
  def series(label, d, opts = {})
    if opts.blank?
      @data << @options.merge(:label => label, :data => d)
    else
      @data << opts.merge(:label => label, :data => d)
    end
  end
  
private
  def map_collection(collection, x, y)
    col = @collection_filter ? @collection_filter.call(collection) : collection
    col.map {|model| [get_coordinate(model, x), get_coordinate(model, y)]}
  end

  def merge_options(name, opts)
    @options.merge!  name => opts
  end
  
  def arguments_to_options(args)
    if args.blank? 
      {:show => true}
    elsif args.is_a? Array
      args.first
    else
      args
    end
  end
  
  def get_coordinate(model, method)
    method.is_a?(Proc) ? method.call(model) : model.send(method)
  end
end