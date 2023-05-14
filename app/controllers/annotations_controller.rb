class AnnotationsController < ApplicationController

  def flashcard_due
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @q = current_user.annotations.filter_by_due.ransack(params[:q])
    #@q.sorts = "RANDOM()" if @q.sorts.empty?

    scope = @q.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 1)

    render :flashcard
  end

  def flashcard_fresh
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @q = current_user.annotations.filter_by_fresh.ransack(params[:q])
    #@q.sorts = "RANDOM()" if @q.sorts.empty?

    scope = @q.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 1)

    render :flashcard
  end

  def index
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @q = current_user.annotations.all.ransack(params[:q])
    #@q.sorts = "RANDOM()" if @q.sorts.empty?

    scope = @q.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 10)
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
