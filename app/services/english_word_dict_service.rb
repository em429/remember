class EnglishWordDictService

  def initialize(word)
    @word = word
  end

  def save_wordnet_result
      @word.update(definition_wordnet: query_wordnet)
      @word.save
  end

  def query_wordnet
    `dict -d wn #{@word.word}`
  end

  def query_gcide
    `dict -d gcide #{@word.word}`
  end

  def query_thesaurus
    `dict -d moby-thesaurus #{@word.word}`
  end


  # TODO: google translate lookup

end
