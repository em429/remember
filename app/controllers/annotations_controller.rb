class AnnotationsController < ApplicationController

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  # FIXME: move this to a job
  def import
    metadata_hashes = calibre_metadata_to_json(params[:opf_file])
    metadata_hashes.each do |hash|
      annotation_hash = hash['annotation']
      highlight_color = annotation_hash["style"]["which"]

      next if annotation_hash['highlighted_text'].blank?
      begin
        annotation = Annotation.create!(
          highlighted_text: normalize_text(annotation_hash['highlighted_text']),
          color: highlight_color,
          notes: annotation_hash['notes'],
          start_cfi: annotation_hash['start_cfi'],
          end_cfi: annotation_hash['end_cfi'],
          timestamp: annotation_hash['timestamp'],
          toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
          book_id: params[:book_id]
        )
      # For easy updates: if highlight is a duplicate, simply skip adding it.
      rescue ActiveRecord::RecordNotUnique
        next
      end

      ## Create a Flashcard row with the default values
      Flashcard.create!(annotation_id: annotation.id, interval: 0, easiness_factor: 2.5)
    end
    redirect_to book_path(params[:book_id])
  end

end
