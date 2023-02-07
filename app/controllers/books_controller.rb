# require 'converters'

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    
    if @book.save
      # We do the epub->plaintext conversion after the save, otherwise
      # the epub is not yet on disk.
      @book.plaintext = epub_to_plaintext(@book.epub_on_disk)
      @book.save
      redirect_to @book, notice: 'Book added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, alert: 'Book successfully deleted'
  end

  def show_plaintext
    @book = Book.find(params[:book_id])
  end

  private

  def book_params
    params.require(:book).permit(%i[title author epub cover fiction])
  end
end
