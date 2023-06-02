class AnnotationsController < ApplicationController

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  def index
    @query = current_user.annotations.all.ransack(params[:q])

    scope = @query.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 10)
  end

end
