class TextExtractionsController < ApplicationController
  def start
    @book = Book.find(params[:book_id])
    @book.epub_to_text
    redirect_to @book
  end
end
