class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["annotation_repetition", "book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["highlighted_text", "notes", "timestamp", "toc_family_titles", "updated_at"]
  end

  # These are safeguard filters that come before ransack:
  # FIXME: ?? move the below scopes to AnnotationRepetition (and rename that to Flashcard..)
  #  It would probably mean big changes in controller too!
  # FIXME: rename fresh to unscored everywhere. way more descriptive.
  scope :fresh_cards, -> { # --> Cards that haven't been scored yet
    joins(:annotation_repetition).where("next_repetition_date IS NULL") }

  scope :due_cards, -> { # --> Cards that are either due today, or are overdue
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
