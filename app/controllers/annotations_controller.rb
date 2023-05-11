class AnnotationsController < ApplicationController
  def root
    redirect_to(annotations_path(mode: "all"))
  end

  def index

    @annotations = current_user.annotations.where(nil)
    
    # Filters
    @annotations = @annotations.filter_by_book_title(params[:title]) if params[:title].present?
    @annotations = @annotations.filter_by_fiction if params[:fiction].to_i == 1
    @annotations = @annotations.filter_by_non_fiction if params[:non_fiction].to_i == 1
    # Sorts
    @annotations = @annotations.sort_by_due_date if params[:sort_by] == "Due"
    @annotations = @annotations.sort_by_random if params["sort_by"] == "Random"
    @annotations = @annotations.sort_by_recent if params["sort_by"] == "Recent"
    # Limit
    @annotations = @annotations.limit(params[:limit].to_i) if params[:limit].present?

    # Modes - shortcut filter + sort combos
    @pagy, @annotations = pagy(@annotations.all) if params[:mode] == "all"
    @annotations = @annotations.flashcards_due if params[:mode] == "flashcards_due"
    @annotations = @annotations.flashcards_fresh if params[:mode] == "flashcards_fresh"

    # If we are not using any mode or limit, turn on pagination:
    unless params[:mode].present? or params[:limit].present?
      @pagy, @annotations = pagy(@annotations)
    end
   
  end

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  # FIXME: move this to a job
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
      # Create an AnnotationRepetition row with the default values
      AnnotationRepetition.create!(annotation_id: annotation.id, interval: 0, easiness_factor: 2.5)
    end
    redirect_to book_path(params[:book_id])
  end
  
end
