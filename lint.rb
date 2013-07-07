$:.unshift(File.dirname(__FILE__) + "/lib")

require 'auto_indent'
require 'optparse'
require 'json'

opt = OptionParser.new

OPTS = {
  :threshold => 0.5,
}

opt.on('--threshold threshold') {|v| OPTS[:threshold] = v.to_f }
opt.on('--stats file') {|v| OPTS[:stats] = v }

opt.parse!(ARGV)

unless OPTS[:threshold] && OPTS[:stats] && ARGV.length > 0
  warn "usage: #{ $0 } --stats examples/learned_plack.txt ~/Plack/**/*.pm"
  exit 1
end

lint = AutoIndent::Lint.new(OPTS[:threshold])

open(OPTS[:stats]).read.each_line{ |line|
  matched = line.match(/^(.),(.),(.*)$/)
  next unless matched

  head = matched[1]
  tail = matched[2]
  stats = matched[3]
  lint.add_rule head, tail, AutoIndent::Probably.new_from_data(JSON.parse(stats))
}

ARGV.each{ |source_code|
  lint.report(source_code)
}
