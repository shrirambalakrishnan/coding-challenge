require 'pry'
require 'benchmark'

class WordToNumberConverter
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def convert
    characters = word.split('')
    digits = characters.map do |character|
      DictionaryProcessor::LETTER_DIGIT_MAPPING[character]
    end

    digits.join
  end
end

class DictionaryProcessor
  attr_reader :words

  LETTER_DIGIT_MAPPING = {
    'A' => 2,
    'B' => 2,
    'C' => 2,
    'D' => 3,
    'E' => 3,
    'F' => 3,
    'G' => 4,
    'H' => 4,
    'I' => 4,
    'J' => 5,
    'K' => 5,
    'L' => 5,
    'M' => 6,
    'N' => 6,
    'O' => 6,
    'P' => 7,
    'Q' => 7,
    'R' => 7,
    'S' => 7,
    'T' => 8,
    'U' => 8,
    'V' => 8,
    'W' => 9,
    'X' => 9,
    'Y' => 9,
    'Z' => 9
  }

  def initialize
    file_location = 'dictionary.txt'
    @words = File.read(file_location).split("\n")
  end

  def generate_word_digit_mapping
    word_number_mapping = words.each_with_object( {} ) do |word, hash|
      hash[word] = WordToNumberConverter.new(word).convert
    end

    p word_number_mapping.size
  end
end

class WordCombinationsGenerator
  attr_reader :input_number

  def initialize(input_number)
    @input_number = input_number
  end

  def generate
    get_mapped_dictionary
  end

  private

  def get_mapped_dictionary
    DictionaryProcessor.new.generate_word_digit_mapping
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

  def generate(number)
    digits_str_array = number.to_s.split('')
    all_combinations = []
    digits_str_array_size = digits_str_array.size

    get_combinations(digits_str_array, all_combinations, 0, digits_str_array_size, "")
    
    all_combinations
  end

  def get_combinations(digits_str_array, all_combinations, index_processed, digits_str_array_size, output_word)
    p '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    p "digits_str_array = #{digits_str_array}"
    p "index_processed = #{index_processed}"
    p "output_word = #{output_word}"
    p '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    
    if index_processed == digits_str_array_size
      all_combinations << output_word

      p "************** output_word = #{output_word} || all_combinations = #{all_combinations} **************"
    else

      digits_str_array.each_with_index do |digit_string, index|
        next if index < index_processed
        
        p "======================== #{digit_string} ========================"

        digit_string_possibilities = NUMBER_TO_DIGIT_MAPPING[digit_string]

        digit_string_possibilities.each do |possible_char|
          p "----------- #{possible_char} -----------"
          output_word = output_word.dup
          output_word[index_processed] = possible_char

          get_combinations( digits_str_array, all_combinations,  index + 1, digits_str_array_size, output_word)
        end
        
      end
      
    end
  end
end

# p Benchmark.measure { WordCombinationsGenerator.new(6686787825).generate }

CombinationGenerator.new.generate(222)
