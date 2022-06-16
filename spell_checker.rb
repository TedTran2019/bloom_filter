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
    while true
      puts 'Enter a word to check against the spell checker or 1337 to exit the program'
      input = gets.chomp
      if input == '1337'
        break
      else
        puts check(input)
      end
    end
  end

  private

  def fill_bloom(filename)
    File.readlines(filename).each { |line| @bloom.add(line.chomp) }
  end
end

filename = 'wordlist.txt'

if __FILE__ == $PROGRAM_NAME
  sc = SpellChecker.new(filename)
  puts sc.check('1337')
  sc.run
end
