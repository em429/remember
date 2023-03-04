class BookPlaintextsController < ApplicationController
  before_action :check_user_owns_page
   
  def show
    @book = current_user.books.find(params[:id])
  end

end
