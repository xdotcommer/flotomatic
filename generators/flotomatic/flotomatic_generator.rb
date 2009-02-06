# Author::    Michael Cowden
# Copyright:: MigraineLiving.com
# License::   Distributed under the same terms as Ruby

class FlotomaticGenerator < Rails::Generator::Base # :nodoc:
  def manifest
    record do |m|
      m.file 'flotomatic.css', "public/stylesheets/flotomatic.css"
      m.file 'flotomatic.js',  "public/javascripts/flotomatic.js"
    end
  end
end
