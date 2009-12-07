class FlotomaticController < ApplicationController
  def basic
    @flot = Flot.new('graph') do |f|
      f.series("Line One", [[1,9], [2,18], [3,36]])
      f.series("Line Two", [[1,4], [2,8], [3,12]])
    end
  end
  
  def graph_types
    @flot = Flot.new('graph') do |f|
      f.series("Lines with Fill", (1..14).map {|n| [n, Math.sin(n)]}, :lines => {:show => true, :fill => true})
      f.series("Points", (1..14).map {|n| [n, Math.cos(n)]}, :points => {:show => true})
      f.series("Bars", [[0, 3], [4, 8], [8, 5], [9, 13]], :bars => {:show => true})
      f.series("Lines & Points", (1..14).map {|n| [n, Math.sqrt(n * 10)]}, :lines => {:show => true}, :points => {:show => true})
    end
  end
  
  def stacked
    @flot = Flot.new('graph') do |f|
      f.stack
      f.bars
      f.series('Plus 5', (1..9).map {|i| [i, i + 5]})
      f.series('Times 2', (1..9).map {|i| [i, i * 2]})
    end
  end
  
  def options
    @flot = Flot.new('graph') do |f|
      f.lines
      f.points
      f.grid(:background_color => {:colors => ['#f00', '#00f']})
      f.xaxis(:ticks => [[1, "One"], [2, "Two"], [3, "Three"]])
      f.series("One", [[1,1], [2,2], [3,3]])
      f.series("Two", [[1,2], [2,4], [3,6]])
      f.series("Three", [[1,3], [2,6], [3,9]])
    end
  end
  
  def checkboxes
    @flot = Flot.new('graph') do |f|
      f.lines(:show => true, :fill => true)
      f.series("One", [[1,1], [2,2], [3,3]])
      f.series("Two", [[1,2], [2,4], [3,6]])
      f.series("Three", [[1,3], [2,6], [3,9]])
    end
  end
end
