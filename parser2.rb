require 'pdf-reader'

class BaseReader
  def initialize(file_path:)
    @client = PDF::Reader.new(file_path)
  end

  attr_reader :client

  def pages
    client.pages.map { |page| Page.new(page) }
  end

  class Page
    def initialize(page)
      @page = page
    end

    attr_reader :page

    def text
      page.text
    end
  end
end


class CustomReader < BaseReader
  def pages
    client.pages.map { |page| Page.new(page) }
  end

  class Page < BaseReader::Page
    START_RECORD_INDEX = 18
    END_RECORD_INDEX = -2
    CLUMN_DELIMITER = "\t"

    def formatted_records
      # NOTE: 以下を行い整形
      # * 2文字以上の空白文字を列の区切りとみなし区切り文字に変換
      # * 空白な行を削除
      # * 各ページのheader部分の行を削除
      text.gsub(/\x20{2,}/, CLUMN_DELIMITER).split(/\R/).reject(&:empty?)[START_RECORD_INDEX..END_RECORD_INDEX]
    end
  end
end

pdf = CustomReader.new(file_path: 'dummy.pdf')
pp parsed = pdf.pages

parsed.each do |page|
  pp page.text
end
