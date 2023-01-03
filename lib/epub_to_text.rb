require 'epub/parser'

def epub_to_text(file_name)
  full_text = ''
  reader = EPUB::Parser.parse(file_name)
  reader.each_page_on_spine do |page|
    page.media_type = 'application/xhtml+xml'
    text = page.content_document.nokogiri
    text.css('style, script').remove
    # Rails.logger.debug text.text
    full_text += text
  end
  full_text
end
