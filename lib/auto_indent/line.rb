module AutoIndent
  class Line
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def indent
      spaces = content.match(/^ */)
      spaces[0].length
    end

    def head
      matched = content.match(/^ *(.)/)
      matched[1]
    end

    def tail
      matched = content.match(/(.)$/)
      matched[1]
    end

    def content_with_indent(size)
      content.gsub(/^ */, ' ' * size)
    end

  end
end
