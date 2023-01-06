require 'epub/parser'

class Book < ApplicationRecord
  has_many :annotations, dependent: :destroy
  has_one_attached :epub
  has_one_attached :cover

  def epub_on_disk
    ActiveStorage::Blob.service.path_for(epub.key)
  end

  def epub_to_text
    full_text = ''
    reader = EPUB::Parser.parse(epub_on_disk)
    reader.each_page_on_spine do |page|
      page.media_type = 'application/xhtml+xml'
      text = page.content_document.nokogiri
      text.css('style, script').remove
      # Rails.logger.debug text.text
      full_text += text
    end
    update(full_text: full_text)
  end
end
