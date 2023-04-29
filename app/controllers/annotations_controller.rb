class AnnotationsController < ApplicationController
  def index
    case params[:filter]
    when "random"
      @annotations = current_user.annotations.random_single
    when "all"
      @pagy, @annotations = pagy(current_user.annotations.random_all)
    when "recent"
      @pagy, @annotations = pagy(current_user.annotations.recent)
    when "spaced"
      @annotations = current_user.annotations.spaced
    else # only show a random one by default
      @annotations = current_user.annotations.random_single
    end
  end

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  # FIXME: move this to it's own model
  def import
    metadata_hashes = calibre_metadata_to_json(params[:opf_file])
    metadata_hashes.each do |hash|
      annotation_hash = hash['annotation']
      next if annotation_hash['highlighted_text'].blank?
      annotation = Annotation.create!(
        highlighted_text: normalize_text(annotation_hash['highlighted_text']),
        notes: annotation_hash['notes'],
        start_cfi: annotation_hash['start_cfi'],
        end_cfi: annotation_hash['end_cfi'],
        timestamp: annotation_hash['timestamp'],
        toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
        book_id: params[:book_id]
      )
      AnnotationRepetition.create!(annotation_id: annotation.id)
    end
    redirect_to book_path(params[:book_id])
  end
  
end
