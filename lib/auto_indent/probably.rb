module AutoIndent
  class Probably
    def initialize
      @data = Hash.new{ 0 }
    end

    def self.new_from_data(data)
      object = new
      object.instance_eval {
        @data = data
      }
      object
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
      keys.first.to_i
    end

    def count(key)
      @data[key]
    end

    def dump
      @data
    end
  end

end
