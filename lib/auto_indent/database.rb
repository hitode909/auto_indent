module AutoIndent
  class Database
    attr_reader :data
    def initialize
      @data = { }
    end

    def parse(string)
      lines = string.split /\r?\n+/
      prev = nil

      lines.each{ |line|
        current = Line.new(line)

        if prev
          @data[prev.tail] ||= { }
          @data[prev.tail][current.head] ||= Probably.new
          @data[prev.tail][current.head].add(current.indent - prev.indent)
        end

        prev = current
      }
    end

    def each
      @data.each_pair{ |tail, data|
        data.each_pair{ |head, prob|
          yield head, tail, prob
        }
      }
    end
  end
end
