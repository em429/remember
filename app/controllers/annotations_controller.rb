class AnnotationsController < ApplicationController

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  def star
    @annotation = current_user.annotations.find(params[:id])
    if params[:star] == "1"
      @annotation.add_star
    else
      @annotation.remove_star
    end

    redirect_back(fallback_location: annotation_path(params[:id]))
  end

  def import
    Annotation.batch_import(params[:book_id], params[:opf_file])
    redirect_to book_path(params[:book_id])
  end

end
