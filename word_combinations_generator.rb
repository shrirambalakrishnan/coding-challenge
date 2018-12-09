require 'pry'
require 'benchmark'

class DictionaryProcessor
  attr_reader :file_location

  def initialize(file_location)
    @file_location = file_location
  end

  def read_words
    File.read(file_location).split("\n")
  end
end

class CombinationGenerator
  NUMBER_TO_DIGIT_MAPPING = {
    '2' => ['A', 'B', 'C'],
    '3' => ['D', 'E', 'F'],
    '4' => ['G', 'H', 'I'],
    '5' => ['J', 'K', 'L'],
    '6' => ['M', 'N', 'O'],
    '7' => ['P', 'Q', 'R', 'S'],
    '8' => ['T', 'U', 'V'],
    '9' => ['W', 'X', 'Y', 'Z']
  }

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def generate
    digits_str_array = number.to_s.split('')
    all_combinations = []
    digits_str_array_size = digits_str_array.size

    get_combinations(digits_str_array, all_combinations, 0, "")
  end

  def get_combinations(digits_str_array, all_combinations, index_to_process, output_word)
    if index_to_process == digits_str_array.size
      all_combinations << output_word.dup # dup - ensures reference of the output_word object is NOT stored in the all_combinations.
    else
      digit_to_process = digits_str_array[0]
      possibilities = NUMBER_TO_DIGIT_MAPPING[digit_to_process]

      possibilities.each do |possible_char|        
        output_word[index_to_process] = possible_char
        get_combinations( digits_str_array, all_combinations,  index_to_process + 1, output_word)
      end
    end

  end
end

# p Benchmark.measure { WordCombinationsGenerator.new(6686787825).generate }

# p Benchmark.measure { CombinationGenerator.new.generate(6686787825) }

# p Benchmark.measure { DictionaryProcessor.new('dictionary.txt').generate_word_digit_mapping }

words_in_dictionary = DictionaryProcessor.new('dictionary.txt').read_words
