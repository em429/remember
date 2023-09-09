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

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "definition_wordnet", "id", "updated_at", "word"]
  end

  def cached_thesaurus
    Rails.cache.fetch "#{cache_key_with_version}/cached_thesaurus"
  end

  def refresh_cached_thesaurus 
    result = EnglishWordDictService.new(self).query_thesaurus
    Rails.cache.write "#{cache_key_with_version}/cached_thesaurus", result, expires_in: 100.hours
  end

end
