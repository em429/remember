class UnscoredFlashcardsController < ApplicationController

  def index
    @query = current_user.flashcards.unscored.ransack(params[:q])
    scope = @query.result(distinct: true).order_by_random

    @pagy, @flashcards = pagy(scope, items: 1)
    @card = @flashcards.first

    render 'flashcards/index'
  end

end
