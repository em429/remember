class EnglishWordsController < ApplicationController
  def index
    @english_words = EnglishWord.all
  end

  def show
    @english_word = EnglishWord.find(params[:id])
  end

  def destroy
    @word = EnglishWord.find(params[:id])
    @word.destroy
    redirect_to english_words_path
  end
end
