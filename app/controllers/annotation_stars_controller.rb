class AnnotationStarsController < ApplicationController
  def index
    @query = current_user.annotations.starred.ransack(params[:q])

    scope = @query.result(distinct: true)
    @pagy, @annotations = pagy(scope, items: 10)

    render 'annotations/index'
  end

  def update
    @annotation = current_user.annotations.find(params[:id])
    if params[:star] == "1"
      @annotation.add_star
      flash[:notice] = "Succesfully starred"
    else
      @annotation.remove_star
      flash[:notice] = "Successfully unstarred"
    end

    redirect_back(fallback_location: annotation_path(params[:id]))
  end

end
