class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition

  def self.ransackable_associations(auth_object = nil)
    ["annotation_repetition", "book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["highlighted_text", "notes", "timestamp", "toc_family_titles", "updated_at"]
  end
  
  # TODO: replace w ransack too
  scope :filter_by_fresh, -> {
    joins(:annotation_repetition).where("next_repetition_date IS NULL") }

  scope :filter_by_due, -> { 
    joins(:annotation_repetition).where("next_repetition_date <= ?", Date.today) }

  validates :highlighted_text, presence: true, allow_blank: false

  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
