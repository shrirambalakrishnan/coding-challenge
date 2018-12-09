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
    digits_str_array = number.split('')
    all_combinations = []
    digits_str_array_size = digits_str_array.size

    get_combinations(digits_str_array, all_combinations, 0, "")

    all_combinations
  end

  def get_combinations(digits_str_array, all_combinations, index_to_process, output_word)
    if index_to_process == digits_str_array.size
      all_combinations << output_word.dup # dup - ensures reference of the output_word object is NOT stored in the all_combinations.
    else
      digit_to_process = digits_str_array[index_to_process]
      possibilities = NUMBER_TO_DIGIT_MAPPING[digit_to_process]

      possibilities.each do |possible_char|        
        output_word[index_to_process] = possible_char
        get_combinations( digits_str_array, all_combinations,  index_to_process + 1, output_word)
      end
    end

  end
end

class WordCombinationsGenerator
  attr_reader :number

  def initialize(number)
    @number = number.to_s
  end

  def generate
    all_combinations = CombinationGenerator.new(number).generate    
    all_words_in_dictionary = DictionaryProcessor.new('dictionary.txt').read_words
    number_size = number.size
    available_combinations = []
    
    all_combinations.each_with_index do |word, index|
      p "==== index = #{index + 1} ======="
      
      # Each word size has to be atleast 3.
      split_position = 2
      
      for i in split_position...number_size do
        word_first_part = word[0..i]
        word_last_part  = word[i+1...number_size]
        
        if i < number_size - 1
          
          if all_words_in_dictionary.bsearch { |x| word_first_part <=> x } && all_words_in_dictionary.bsearch{ |x| word_last_part <=> x }
            available_combinations << [word_first_part, word_last_part]
          end
        else           
          
          if all_words_in_dictionary.bsearch { |x| word_first_part <=> x }
            available_combinations << word_first_part
          end
        end
      end
    end

    available_combinations
  end
end

# p WordCombinationsGenerator.new(6686787825).generate
p WordCombinationsGenerator.new(2282668687).generate
