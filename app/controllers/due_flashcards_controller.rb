class DueFlashcardsController < ApplicationController
  def index
    @query = current_user.flashcards.due.ransack(params[:q])
    scope = @query.result(distinct: true).order_by_due_first
    @pagy, @flashcards = pagy(scope, items: 1)
    @card = @flashcards.first

    render 'flashcards/index'
  end
end
