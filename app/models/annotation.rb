class Annotation < ApplicationRecord
  belongs_to :book
  has_one :flashcard, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["flashcard", "book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["highlighted_text", "notes", "timestamp", "toc_family_titles", "updated_at"]
  end

  validates :highlighted_text, presence: true, allow_blank: false
  
  # Return the chapters as an array
  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
