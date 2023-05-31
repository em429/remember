class AnnotationImportsController < ApplicationController
  def create
    Annotation.batch_import(params[:book_id], params[:opf_file])
    redirect_to book_path(params[:book_id])
  end
end
