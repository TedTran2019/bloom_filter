# bloom_filter
A simple bloom filter implementation to teach myself.

## Purpose
Given expected size and a desired false positive probability, calculate the size
of the bit array. Can also calculate the amount of times to hash, but using the 
Kirsch-Mitzenmacher optimization is probably much better. It's a space-efficient probabilistic data structure that's used to test whether an element is a member of a set.

## tl;dr bloom filter
1. Array of (x) length
2. **add**: index hash(input) % x, set to true if false
3. **include?**: index hash(input) % x

## Legend
- ε : false positive probability
- m : number of bits
- n : number of inserted elements
- k : number of hashes
## Implementation
1. Underlying data structure is a bit array

    a. What should the ideal size of the bit array be?

    b. $-\frac{nlnε}{(ln2)^2}$

2. What hashing function should be used?

    a. One with a good trade-off between speed and uniformity: murmur3

    b. For best uniformity, a crytographic hash like SHA-256.

3. How many hashing functions to use?

    a. $-log_{2}ε$

    b. $\frac{m}{n}ln2$

    c. Instead of hashing with k functions, can hash with two functions aka the [Kirsch-Mitzenmacher optimization](https://www.eecs.harvard.edu/~michaelm/postscripts/tr-02-05.pdf).
## Extra
1. How to calculate ε

    a. $(1 - (1 - \frac{1}{m})^{kn})^k$

2. Resizing the bloom filter

## Usage
```
bloom = BloomFilter.new(expected_size, false_positive_probability)
b.add('test')
b.include?('test')
```

## Misc
1. Supposedly using [Ruby's bignum to implement a bit array is slow](https://nithinbekal.com/posts/bit-arrays-ruby/), haha.
2. [Cool visualization with formulas](https://hur.st/bloomfilter/)