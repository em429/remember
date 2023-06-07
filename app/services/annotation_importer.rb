# Imports annotations from a Calibre metadata.opf file into db and creates "unscored"
# Flashcard rows as well for each Annotation.
class AnnotationImporter
  def import(opf_file, book)
    metadata_hashes = calibre_metadata_to_json(opf_file)
    metadata_hashes.each do |hash|
      annotation_hash = hash['annotation']
      highlight_color = annotation_hash["style"]["which"]

      next if annotation_hash['highlighted_text'].blank?

      begin
        fresh_annotation = book.annotations.create!(
          highlighted_text: normalize_text(annotation_hash['highlighted_text']),
          color: highlight_color,
          notes: annotation_hash['notes'],
          start_cfi: annotation_hash['start_cfi'],
          end_cfi: annotation_hash['end_cfi'],
          timestamp: annotation_hash['timestamp'],
          toc_family_titles: JSON.generate(annotation_hash['toc_family_titles'])
        )
      # For easy updates: if highlight is a duplicate, simply skip adding it.
      rescue ActiveRecord::RecordNotUnique
        next
      end

      # Create an unscored Flashcard. Default values set in db.
      Flashcard.create!(annotation_id: fresh_annotation.id)

    end
  end
end  
