require_relative '../word_combinations_generator.rb'

describe WordCombinationsGenerator do
  
  describe 'generate' do

    context 'when initial verification cases are passed' do

      it 'should pass case 1' do
        input = 6686787825
        valid_output = [["motor", "usual"], ["noun", "struck"], ["nouns", "truck"], ["nouns", "usual"], ["onto", "struck"], "motortruck"]

        expect(WordCombinationsGenerator.new(input).generate).to eq(valid_output)
      end

      it 'should pass case 2' do
        input = 2282668687
        valid_output = [["act", "amounts"], ["act", "contour"], ["acta", "mounts"], ["bat", "amounts"], ["bat", "contour"], ["cat", "contour"], "catamounts"]

        expect(WordCombinationsGenerator.new(input).generate).to eq(valid_output)
      end
    end
    
  end

end
