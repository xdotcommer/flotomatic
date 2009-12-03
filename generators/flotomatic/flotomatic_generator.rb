# Author::    Michael Cowden
# Copyright:: MigraineLiving.com
# License::   Distributed under the same terms as Ruby

class FlotomaticGenerator < Rails::Generator::Base # :nodoc:
  def manifest
    record do |m|
      m.file 'flotomatic.css', "public/stylesheets/flotomatic.css"
      m.file 'flotomatic.js',  "public/javascripts/flotomatic.js"
      m.file 'jquery.js', "public/javascripts/jquery.js"
      m.file 'jquery.flot.pack.js', "public/javascripts/jquery.flot.pack.js"
      m.file 'excanvas.pack.js', "public/javascripts/excanvas.pack.js"
    end
  end
end
