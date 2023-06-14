class EnglishWordThesaurusLookupsController < ApplicationController
  def create
    @word = EnglishWord.find(params[:id])

    debu = @word.refresh_cached_thesaurus

    logger.debug(debu)

    redirect_back fallback_location: english_word_path(@word)

  end
end
