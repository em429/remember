class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["annotation_repetition", "book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["highlighted_text", "notes", "timestamp", "toc_family_titles", "updated_at"]
  end
  
  # These are safeguard filters that come before ransack, to make sure
  # flashcard mode shows only:
  #   "fresh cards" --> cards that haven't been scored
  #   "due cards" --> cards that are either due today, or are overdue
  scope :filter_by_fresh, -> {
    joins(:annotation_repetition).where("next_repetition_date IS NULL") }

  scope :filter_by_due, -> { 
    joins(:annotation_repetition).where("next_repetition_date <= ?", Date.today) }

  scope :order_by_due_first, -> {
    order("annotation_repetition.next_repetition_date ASC")
  }
  scope :order_by_random, -> { order("RANDOM()") }

  validates :highlighted_text, presence: true, allow_blank: false

  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
