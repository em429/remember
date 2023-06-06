class EnglishWordImportsController < ApplicationController
  def new
  end

  def create
    EnglishWord.import_wordlist(params[:wordlist])

    redirect_to english_words_path, notice: "Successfully imported"
 
   
  end

end
