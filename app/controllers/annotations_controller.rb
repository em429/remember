class AnnotationsController < ApplicationController
  def index
    case params[:filter]
    when "random"
      @annotations = Annotation.random_single
    when "all"
      @pagy, @annotations = pagy(Annotation.random_all)
    when "recent"
      @pagy, @annotations = pagy(Annotation.recent)
    else # only show a random one by default
      @annotations = Annotation.random_single
      
    end
  end

  def show
    @annotation = Annotation.find(params[:id])
  end
end
