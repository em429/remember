require 'spaced_repetition'

class FlashcardsController < ApplicationController

  # TODO: refactor
  def show_due
    @query = current_user.flashcards.due.ransack(params[:q])

    scope = @query.result(distinct: true).order_by_due_first
    @pagy, @flashcards = pagy(scope, items: 1)
    @card = @flashcards.first

    render :show
  end

  # TODO: refactor
  def show_unscored
    @query = current_user.flashcards.unscored.ransack(params[:q])

    scope = @query.result(distinct: true).order_by_random
    @pagy, @flashcards = pagy(scope, items: 1)
    @card = @flashcards.first

    render :show
  end

  def update
    @annotation = current_user.annotations.find(params[:id])
    @flashcard = @annotation.flashcard

    @prev_interval = @flashcard.interval
    @prev_ef = @flashcard.easiness_factor

    sm2 = SpacedRepetition::Sm2.new(
      params["flashcard"]["score"].to_i,
      @prev_interval,
      @prev_ef
    )

    @flashcard.update(
      interval: sm2.interval,
      easiness_factor: sm2.easiness_factor,
      next_repetition_date: sm2.next_repetition_date
    )

    @flashcard.save

    redirect_back(fallback_location: flashcards_path)

  end

  private

  def flashcard_params
    params.require(:flashcard).permit(
      %i[score]
    )
  end
  
end
