class FlotomaticGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'flotomatic.css', "public/stylesheets/flotomatic.css"
      m.file 'flotomatic.js',  "public/javascripts/flotomatic.js"
    end
  end
end
