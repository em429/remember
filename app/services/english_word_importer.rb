class EnglishWordImporter

  def initialize(wordlist)
    @wordlist = wordlist
  end

  def import
    @wordlist.each_line do |word|
      EnglishWord.create!(word: word.strip())
      rescue ActiveRecord::RecordNotUnique
        next
    end
  end

end
