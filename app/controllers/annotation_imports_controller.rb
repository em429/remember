class AnnotationImportsController < ApplicationController
  def create

    @book = Book.find(params[:book_id])
    import = AnnotationImporter.new.import(params[:opf_file], @book)
    redirect_to book_path(@book)

  end
end
