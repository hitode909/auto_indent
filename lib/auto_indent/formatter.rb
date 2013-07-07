module AutoIndent
  class Formatter
    def initialize
      @rule = { }
    end

    def add_rule(tail, head, prob)
      @rule[tail] ||= { }
      @rule[tail][head] = prob
    end

    def format(source_code)
      prev = nil
      indent = 0
      source_code.each_line.map{ |line_content|
        begin
          current = AutoIndent::Line.new(line_content)

          if prev
            diff = diff_for(prev.tail, current.head)
            indent += diff;
            indent = [0, indent].max
            prev = current
            current.content_with_indent(indent)
          else
            prev = current
            line_content
          end
        rescue
          line_content
        end
      }.join("")
    end

    def diff_for(tail, head)
      @rule[tail][head].result || 0
    rescue => error
      warn error
      0
    end
  end
end
