require File.dirname(__FILE__) + '/../spec_helper'

describe "flot helper" do
  helper_name "flot"

  before(:each) do
    @class       = "stylin"
    @placeholder = "placeholder"
    @flot        = Flot.new(@placeholder, :class => @class)
    @data        = "data"
    @options     = "options"

    @flot.data.stub!(:to_json).and_return @data
    @flot.options.stub!(:to_json).and_return @options
  end
  
  describe "flot_includes" do
    it "should include the appropriate javascript files" do
      flot_includes.should match(/jquery\.js/)
      flot_includes.should match(/jquery\-ui\.js/)
      flot_includes.should match(/jrails\.js/)
      flot_includes.should match(/jquery\.flot/)
      flot_includes.should match(/excanvas/)
      flot_includes.should have_tag('script')
    end
  end
  
  describe "flot_canvas" do
    it "should create a div with id of placeholder" do
      flot_canvas("placeholder").should have_tag('div#placeholder')
    end

    it "should create pass through html options" do
      flot_canvas("placeholder", :class => 'stylin').should have_tag('div[id=?][class=?]', 'placeholder', 'stylin')
    end
  
    it "should work similiarly for with a object" do
      flot = Flot.new("placeholder", :class => 'stylin')
      flot_canvas(flot).should have_tag('div[id=?][class=?]', flot.placeholder, 'stylin')
    end
  
  end

  describe "flot_graph" do
    it "should generate javascript with the appropriate ready function" do
      flot_graph(@placeholder, @flot).should have_tag('script[type=?]', 'text/javascript')
      flot_graph(@placeholder, @flot).should match(/\$\(function\(\)\s*\{/)
      flot_graph(@placeholder, @flot).should match(/\}\s*\)\s*;/)
    end
    
    it "should set the data, options, and placeholder variables" do
      flot_graph(@placeholder, @flot).should =~ /var\s+data\s*=\s*#{@data}\s*;/
      flot_graph(@placeholder, @flot).should =~ /var\s+options\s*=\s*#{@options}\s*;/
      flot_graph(@placeholder, @flot).should =~ /var\s+placeholder\s*=\s*\$\("\##{@placeholder}"\)\s*;/
    end
    
    it "should call the plot function with appropriate arguments" do
      flot_graph(@placeholder, @flot).should =~  /var\s+plot\s+=\s+\$\.plot\(placeholder\s*,\s*data\s*,\s*options\s*\);/
    end
    
    it "should evaluate a block and pass it through to the end of the javascript" do
      _erbout = ''
      flot_graph(@placeholder, @flot) { _erbout.concat "// My favorite number is #{3 + 4}" }.should =~ /My favorite number is 7/
    end
  end
  
  describe "flot_tooltip" do
    before(:each) do
      _erbout = ""
    end
    it "should generate the tooltip call" do
    end
    it "should use the placeholder set in flot_graph" do
      flot_graph(@placeholder, @flot) { puts instance_variable_get(@placeholder) }
    end
  end
end