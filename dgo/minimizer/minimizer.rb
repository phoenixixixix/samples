# minimizer.rb
module Minimizer
  class << self
    def call(string)
      string.scan(/\d+|[a-z]+/i).each do |substring|
        next if substring.size < 3
        substring.size.downto(3).each do |a|
          substring.chars.each_cons(a) do |array|
            if (array == (array[0]..array[-1]).to_a || array.reverse == (array[-1]..array[0]).to_a)
              string.gsub!(array.join, [array[0], array[-1]].join('-'))
            end
          end
        end
      end
      string
    end
  end
end
