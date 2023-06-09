# == Schema Information
#
# Table name: english_words
#
#  id                 :integer          not null, primary key
#  word               :string
#  definition_wordnet :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class EnglishWord < ApplicationRecord

    def cached_thesaurus
      Rails.cache.fetch "#{cache_key_with_version}/cached_thesaurus", expires_in: 100.hours do
        EnglishDictLookup.new(self).thesaurus
      end
    end

end
