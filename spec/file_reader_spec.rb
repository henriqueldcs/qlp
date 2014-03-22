require "spec_helper"
require "file_reader"

describe FileReader do
  describe "#next_line" do
    it "deve retornar a próxima linha do arquivo." do 
      reader = FileReader.new 'games.log'
      next_line = reader.next_line
      
      line_expected = '  0:00 ------------------------------------------------------------\n'
      
      expect(next_line).to eq next_line
    end
  end
end