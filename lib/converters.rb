def calibre_metadata_to_json(opf_file)
  xml = Nokogiri::XML.parse(opf_file)
  annotation_nodes = xml.search('meta[name="calibre:annotation"]')
  annotations = []
  annotation_nodes.each do |n|
    attribute_hash = JSON.parse(n.attributes['content'].value)
    next if attribute_hash['annotation']['removed']

    annotations << attribute_hash
  end
  annotations
end

def normalize_text(target)
  target.gsub(/[\r\n\t]/, " ").squeeze(" ")
end

def epub_to_plaintext(file)
  full_string = ''

  reader = EPUB::Parser.parse(file)
  reader.each_page_on_spine do |page|
    page.media_type = 'application/xhtml+xml'
    html = page.read
    parsed_page = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    parsed_page.css('style, script').remove
    full_string += parsed_page
  end

  normalize_text(full_string)
end
