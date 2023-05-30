class AnnotationStarsController < ApplicationController
  def index
    #@book_titles = [[ "Any", "" ]] + Book.all.pluck(:title)
    @query = current_user.annotations.starred.ransack(params[:q])

    scope = @query.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 10)
  end

  def create
    @annotation = current_user.annotations.find(params[:id])
    if params[:star] == "1"
      @annotation.add_star
    else
      @annotation.remove_star
    end

    redirect_back(fallback_location: annotation_path(params[:id]))
  end

  def update
  end

end
