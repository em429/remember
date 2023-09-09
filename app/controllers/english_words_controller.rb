class EnglishWordsController < ApplicationController
  def index
    @query = EnglishWord.all.ransack(params[:q])
    @english_words = @query.result
  end

  def show
    @english_word = EnglishWord.find(params[:id])

    if not @english_word.definition_wordnet.present?
      EnglishWordDictService.new(@english_word).save_wordnet_result
    end

  end

  def destroy
    @english_word = EnglishWord.find(params[:id])
    @english_word.destroy
    redirect_to english_words_path
  end

  def edit
    @english_word = EnglishWord.find(params[:id])
  end

  def update
    @english_word = EnglishWord.find(params[:id])
    if @english_word.update(english_word_params)
      redirect_to english_words_path, notice: "English word succesfully updated"
    else
      render :new, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotUnique
      redirect_to english_words_path, alert: "Aborting: Updating the word would create a duplicate."
  end

  private

  def english_word_params
    params.require(:english_word).permit(:word)
  end


end
