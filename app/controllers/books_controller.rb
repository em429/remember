require 'converters'

class BooksController < ApplicationController
  # except: index, create, new
  before_action :check_user_owns_page, only: %i[ show edit update destroy ]
  
  def index
    @books = current_user.books
  end

  def show
    @book = current_user.books.find(params[:id])
  end

  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.build(book_params)
    
    if @book.save
      # We do the epub->plaintext conversion after the first save, otherwise
      # the epub is not yet on disk, then we save again.
      if @book.epub_on_disk.present?
        @book.plaintext = epub_to_plaintext(@book.epub_on_disk)
        @book.save
      end
      redirect_to @book, notice: 'Book added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = current_user.books.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    # Same as in create, we convert after update, and save again.
    if @book.update(book_params)
      if @book.epub_on_disk.present?
        @book.plaintext = epub_to_plaintext(@book.epub_on_disk)
        @book.save
      end
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy
    redirect_to books_path, alert: 'Book successfully deleted'
  end

  private

  def book_params
    params.require(:book).permit(%i[title author epub cover fiction user_id])
  end
  
end
