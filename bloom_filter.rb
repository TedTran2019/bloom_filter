require 'bitarray'
require 'murmurhash3'

class BloomFilter
  def initialize(expected_size, false_positive_probability)
    @size = expected_size
    @fp_probability = false_positive_probability
    @nbr_bits = BloomFilter.calc_bits(expected_size, false_positive_probability)
    @hash_count = BloomFilter.calc_hash_count(@nbr_bits, expected_size)
    @bit_array = BitArray.new(@nbr_bits)
  end

  def self.calc_bits(n, p)
    (-(n * Math.log(p)) / (Math.log(2)**2)).round
  end

  def self.calc_hash_count(m, n)
    ((m / n) * Math.log(2)).round
  end

  def add(str)
    @hash_count.times do |seed|
      @bit_array[hash(str, seed)] = 1
    end
  end

  def include?(str)
    @hash_count.times do |seed|
      return false if @bit_array[hash(str, seed)].zero?
    end
    true
  end

  private

  def hash(str, seed)
    MurmurHash3::V32.str_hash(str, seed) % @nbr_bits
  end
end
