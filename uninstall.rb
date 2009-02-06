require 'fileutils'

directory = File.dirname(__FILE__)

FileUtils.rm_r File.join(directory, "..", "..", "..", "public", "javascripts", "flotomatic.js")
FileUtils.rm_r File.join(directory, "..", "..", "..", "public", "stylesheets", "flotomatic.css")
