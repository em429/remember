class EnglishWordImportsController < ApplicationController
  def new
  end

  def create
    EnglishWordImporter.new(params[:wordlist]).import

    redirect_to english_words_path, notice: "Successfully imported"
   
  end

end
