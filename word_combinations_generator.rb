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

p Benchmark.measure { WordCombinationsGenerator.new(6686787825).generate }
