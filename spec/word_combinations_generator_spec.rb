require_relative '../word_combinations_generator.rb'

describe WordCombinationsGenerator do
  
  describe 'generate' do

    context 'when initial verification cases are passed' do

      it 'should pass basic case 1' do
        input = 6686787825
        valid_output = [["MOTOR", "TRUCK"], "MOTORTRUCK", ["MOTOR", "USUAL"], ["NOUN", "STRUCK"], ["NOUNS", "TRUCK"], ["NOUNS", "USUAL"], ["ONTO", "STRUCK"]]

        expect(WordCombinationsGenerator.new(input).generate).to eq(valid_output)
      end

      it 'should pass basic case 2' do
        input = 2282668687
        valid_output = [["ACT", "AMOUNTS"], ["ACTA", "MOUNTS"], ["ACT", "CONTOUR"], ["BAT", "AMOUNTS"], ["BAT", "CONTOUR"], ["CAT", "AMOUNTS"], "CATAMOUNTS", ["CAT", "CONTOUR"]]

        expect(WordCombinationsGenerator.new(input).generate).to eq(valid_output)
      end
    end
    
  end

end
