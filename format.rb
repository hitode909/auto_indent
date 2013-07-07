$:.unshift(File.dirname(__FILE__) + "/lib")

require 'auto_indent'
require 'json'

unless ARGV.length == 2
  warn "usage: #{ $0 } LEARNED_DATA SOURCE_CODE > FORMATTED_SOURCE_CODE"
end

LEARNED_DATA, SOURCE_CODE = *ARGV

formatter = AutoIndent::Formatter.new

open(LEARNED_DATA).read.each_line{ |line|
  matched = line.match(/^(.),(.),(.*)$/)
  next unless matched

  head = matched[1]
  tail = matched[2]
  stats = matched[3]
  formatter.add_rule head, tail, AutoIndent::Probably.new_from_data(JSON.parse(stats))
}

puts formatter.format(open(SOURCE_CODE).read)
