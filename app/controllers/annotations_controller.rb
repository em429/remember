class AnnotationsController < ApplicationController

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

  def import
    Annotation.batch_import(params[:book_id], params[:opf_file])
    redirect_to book_path(params[:book_id])
  end

end
