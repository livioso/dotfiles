#! /usr/bin/ruby

require 'optparse'

def main
  screenDimCommand = '
  OptionParser.new do |opts|
    opts.banner = "Usage: dim-screen.rb [options]"
    opts.on("-d", "--dim", "Dim screen to convenient level.") do |v|
      screenDimCommand = 'redshift -m randr -b 0.6 -O 4250'
    end
    opts.on("-r", "--reset", "Resets dimming level.") do |v|
      screenDimCommand = 'redshift -m randr -x'
    end
  end.parse!

  # run the screen diming command
  system(screenDimCommand)

end

main
