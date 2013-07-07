module AutoIndent
  class Probably
    def initialize
      @data = Hash.new{ 0 }
    end

    def self.new_from_data(data)
      data2 = { }
      data.each_pair{ |k, v|
        data2[k.to_i] = v.to_i
      }
      object = new
      object.instance_eval {
        @data = data2
      }
      object
    end

    def add(key)
      @data[key] += 1
    end

    def prob(key)
      count(key) / sum.to_f
    end

    def sum
      @data.values.inject(0){ |a, b| a + b }
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
      @data[key] || 0
    end

    def dump
      @data
    end
  end

end
