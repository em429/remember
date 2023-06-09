class EnglishDictLookup
  def initialize(word)
    @word = word
  end

  ## If definition is present in the db, take it from there.
  ## Otherwise, look it up using dictd client, save it to DB and return it.
  def fetch_wordnet_definition
    if @word.definition_wordnet.present?
      @word.definition_wordnet
    else
      definition = `dict -d wn #{@word.word}`
      @word.update(definition_wordnet: definition)
      @word.save
      return definition
    end
  end

  def gcide_definition
    `dict -d gcide #{@word.word}`
  end

  def thesaurus
    `dict -d moby-thesaurus #{@word.word}`
  end

  # TODO: google translate lookup

end
