class EnglishWord < ApplicationRecord

    def wordnet_definition
      Rails.cache.fetch "#{cache_key_with_version}/wordnet_definition2", expires_in: 100.hours do
        `dict -d wn #{word}`
      end
    end

    def moby_thesaurus
      Rails.cache.fetch "#{cache_key_with_version}/moby_thesaurus2", expires_in: 100.hours do
        `dict -d moby-thesaurus #{word}`
      end
    end

end
