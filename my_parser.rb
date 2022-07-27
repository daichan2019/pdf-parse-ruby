require 'pdf-reader'

class ParserService
  START_RECORD_INDEX = 18
  END_RECORD_INDEX = -2
  CLUMN_DELIMITER = "\t"

  def initialize(file_path:)
    @reader = PDF::Reader.new(file_path)
  end

  def parse
    @reader.pages.map { |page| @text =  page.text.split("\n") }
  end
end

file = ParserService.new(file_path: 'dummy.pdf')
file.parse
