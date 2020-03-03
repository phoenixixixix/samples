# multiliner.rb
module Multiliner
  class << self
    def call(text, length)
      words = text.split(' ')
      array = []
      string = ''

      words.each_with_index do |word, index|
        if word.length > length
          array << string
          string = ''
          word.chars.each_slice(length) do |substring|
            substring.length == length ? array << substring.join : string = substring.join
          end
        else
          if (string.length + word.length) < length
            string = [string, word].join(' ').strip
            next
          else
            array << string
            string = word
          end
        end
        array << string if words.count == index+1
      end
      array
    end
  end
end
