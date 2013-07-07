module AutoIndent
  class Lint
    def initialize(threshold)
      @threshold = threshold
      @rule = { }
    end

    def threshold
      @threshold
    end

    def add_rule(tail, head, prob)
      @rule[tail] ||= { }
      @rule[tail][head] = prob
    end

    def report(source_file)
      prev = nil
      indent = 0
      open(source_file).read.each_line.each_with_index{ |line_content, i|
        line_num = i+1
        line_content.chomp!
        next unless line_content.length > 0

        current = AutoIndent::Line.new(line_content)

        unless prev
          prev = current
          next
        end

        prob = prob_for(prev.tail, current.head)

        unless prob
          prev = current
          next
        end

        actual_diff = current.indent - prev.indent
        recommended_diff = diff_for(prev.tail, current.head)

        if actual_diff != recommended_diff && prob.prob(recommended_diff) > threshold

          offset = 0
          if prev.indent + recommended_diff < 0
            offset = - recommended_diff
          end

          puts "#{ source_file } line #{line_num}, #{ actual_diff } should #{ recommended_diff } by #{ prob.prob(recommended_diff) }"
          puts prev.content_with_indent(prev.indent + offset + 2)
          puts "- #{current.content_with_indent(current.indent + offset)}"
          puts "+ #{current.content_with_indent(prev.indent + offset + recommended_diff)}"
          puts
        end
        prev = current
      }
    end

    def diff_for(tail, head)
      @rule[tail][head].result || 0
    rescue => error
      warn "diff #{error}"
      0
    end

    def prob_for(tail, head)
      @rule[tail][head]
    rescue => error
      # warn ["prob_for #{tail}#{head}", error]
      nil
    end

  end
end






