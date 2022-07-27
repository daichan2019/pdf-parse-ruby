require 'pdf-reader'

class ParserService
  START_RECORD_INDEX = 18
  END_RECORD_INDEX = -2
  CLUMN_DELIMITER = "\t"

  def initialize(file_path:)
    @client = PDF::Reader.new(file_path)
  end

  def parse
    @client.pages.map do |page|
      # * 2文字以上の空白文字を列の区切りとみなし区切り文字に変換
      # * 空白な行を削除
      # * 各ページのheader部分の行を削除
      page.text.gsub(/\x20{2,}/, CLUMN_DELIMITER).split(/\R/).reject(&:empty?)[START_RECORD_INDEX..END_RECORD_INDEX]
    end
  end
end

file = ParserService.new(file_path: 'dummy.pdf')
pp file.parse
