def extract_highlights(opf_file)
  xml = Nokogiri::XML.parse(opf_file)
  annotation_nodes = xml.search('meta[name="calibre:annotation"]')
  json_objects = []
  annotation_nodes.each do |n|
    json_parsed = JSON.parse(n.attributes['content'].value)
    next if json_parsed['annotation']['removed']

    json_objects.push(json_parsed)
  end
  json_objects
end
