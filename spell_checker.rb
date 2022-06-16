require_relative 'bloom_filter'

# wordlist.txt from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
# contains 370105 words
# spellwords.txt from https://www.openbookproject.net/py4fun/spellCheck/spellCheck.html
# contains 53,751 words
class SpellChecker
  def initialize(filename, word_count)
    @bloom = BloomFilter.new(word_count, 0.001)
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
word_count = 370_105
filename2 = 'spellwords.txt'
word_count2 = 53_751

# if __FILE__ == $PROGRAM_NAME
#   sc = SpellChecker.new(filename2, word_count2)
#   sc.run
# end

def generate_rand_five_char
  str = ''
  5.times do
    str << rand(97..122).chr
  end
  str
end

dict = {}
File.readlines(filename2).each { |line| dict[line.chomp] = true }
sc = SpellChecker.new(filename2, word_count2)
false_pos = 0
1000.times do
  word = generate_rand_five_char
  false_pos += 1 if !dict[word].nil? != sc.check(word)
end
puts false_pos
