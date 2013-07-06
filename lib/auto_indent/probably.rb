module AutoIndent
  class Probably
    def initialize
      @data = Hash.new{ 0 }
    end

    def add(key)
      @data[key] += 1
    end

    def inspect
      detail = keys.map{ |key| "#{ key.inspect }: #{ count(key) }" }.join(', ')
      "#{self.class} #{ result.inspect } (#{ detail })"
    end

    def keys
      @data.keys.sort_by{ |key| count(key) }.reverse
    end

    def result
      keys.first
    end

    def count(key)
      @data[key]
    end
  end

end
