module FlotHelper
  def flot_includes
    return <<-EOJS
      #{stylesheet_link_tag 'flotomatic'}
  	  <!--[if IE]> #{javascript_include_tag('excanvas.pack.js')} </script><![endif]-->
      #{javascript_include_tag('jquery', 'jquery-ui', 'jrails', 'jquery.flot.pack.js', 'flotomatic')}
    EOJS
  end
  
  def flot_canvas(arg, options = {})
    if arg.is_a? Flot
      content_tag :div, "", options.merge(arg.html_options.merge(:id => arg.placeholder, :class => 'flot_canvas'))
    else # arg is the placeholder
      content_tag :div, "", options.merge(:id => arg, :class => 'flot_canvas')
    end
  end
  
  def flot_selections(options = {})
    # choices = flot.data.map do |dataset| 
    #   label = content_tag :label, dataset[:label], :for => dataset[:label]
    #   input = content_tag :input, label, :type => 'checkbox', :name => dataset[:label], :checked => 'checked'
    #   '<br/>' + input
    # end
    content_tag :div, '', options.merge(:id => "flot_choices")
  end
  
  def flot_graph(placeholder, flot, &block)
    graph = javascript_tag <<-EOJS
      $(function() {
        var data        = #{flot.data.to_json};
        var options     = #{flot.options.to_json};
        var flotomatic  = new Flotomatic('#{placeholder}', data, options);
        // Custom Javascript provided in block to flot_graph
        #{capture(&block) if block_given?}
      });
    EOJS
    
    return graph unless block_given?
    concat graph, block.binding
  end
  
  def flot_plot(options = {:dynamic => false, :overview => false})
    return <<-EOJS
      #{options[:dynamic] ? "flotomatic.graphDynamic();" : "flotomatic.graph();"}
      #{'flotomatic.graphOverview();' if options[:overview]}
    EOJS
  end
  
  def flot_overview(text = '')
    content_tag(:div, text, :id => 'flot_overview', :class => 'flot_overview')
  end
  
  
#  def flot_plot(placeholder, flot, data, options)

  # TODO: specs, different defaults based on time axis
  def flot_tooltip(&block)
    start, finish = "flotomatic.createTooltip(", ");"
    if block_given?
      concat start, block.binding
      block.call
      concat finish, block.binding
    else
      start + "flotomatic.tooltipFormatter" + finish;
    end
  end
end