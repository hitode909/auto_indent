$:.unshift(File.dirname(__FILE__) + "/lib")

require 'auto_indent'

unless ARGV.length > 0
  warn "usage: #{ $0 } ~/PATH_TO_SOME_PROJECT/lib/**/*.rb > LEARNED_DATA"
  warn "usage: find ~/PATH_TO_SOME_PROJECT/lib/ | grep '\.rb$' | xargs ruby #{ $0 } > LEARNED_DATA"
end

database = AutoIndent::Database.new

ARGV.each{ |file|
  begin
    warn file
    database.parse(open(file).read)
  rescue => error
    warn error
  end
}

database.each{ |head, tail, prob|
  puts [tail, head, prob.result].join(",") if prob.result != 0
}
