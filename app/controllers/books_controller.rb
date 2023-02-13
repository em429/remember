require 'converters'

class BooksController < ApplicationController
  # Index is already rendered by user's own page, create and new needs id so we skip
  before_action :check_user_owns_page, except: %i[index create new show_plaintext]
  
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
    @book = current_user.books.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
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

  def show_plaintext
    @book = current_user.books.find(params[:book_id])
  end

  private

  def book_params
    params.require(:book).permit(%i[title author epub cover fiction user_id])
  end

  def check_user_owns_page
    @book = current_user.books.find_by_id(params[:id])
    if @book.nil?
      redirect_to(
        root_url,
        status: :see_other,
        notice: "Couldn't find book with id #{params[:id]}")
    end
  end
  
end
