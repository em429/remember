class AnnotationsController < ApplicationController

  # TODO: merge flashcard_due and fresh? The only difference is the scope + order
  def flashcard_due
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @query = current_user.annotations.due_cards.ransack(params[:q])
    # @q = current_user.flashcards.due.ransack(params[:q])

    scope = @query.result(distinct: true).order_by_due_first
    @pagy, @annotations = pagy(scope, items: 1)

    render :flashcard
  end

  def flashcard_fresh
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @query = current_user.annotations.fresh_cards.ransack(params[:q])
    # @q = current_user.flashcards.unscored.ransack(params[:q])

    scope = @query.result(distinct: true).order_by_random
    @pagy, @annotations = pagy(scope, items: 1)

    render :flashcard
  end

  def index
    @book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @query = current_user.annotations.all.ransack(params[:q])

    scope = @query.result(distinct: true)
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

      ## Create an AnnotationRepetition row with the default values
      AnnotationRepetition.create!(annotation_id: annotation.id, interval: 0, easiness_factor: 2.5)
    end
    redirect_to book_path(params[:book_id])
  end

end
