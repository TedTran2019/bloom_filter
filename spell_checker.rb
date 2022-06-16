# frozen_string_literal: true

require_relative 'bloom_filter'

# wordlist.txt from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
# contains 370105 words
class SpellChecker
  def initialize(filename)
    @bloom = BloomFilter.new(370_105, 0.001)
    fill_bloom(filename)
  end

  def check(word)
    @bloom.include?(word)
  end

  def run
    loop do
      puts 'Enter a word to check against the spell checker or 1337 to exit the program'
      input = gets.chomp
      break if input == '1337'

      puts check(input)
    end
  end

  private

  def fill_bloom(filename)
    File.readlines(filename).each { |line| @bloom.add(line.chomp) }
  end
end

filename = 'wordlist.txt'
filename2 = 'spellwords.txt'

if __FILE__ == $PROGRAM_NAME
  sc = SpellChecker.new(filename2)
  sc.run
end
