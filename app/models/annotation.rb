class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition

  # Timestamp is when the highlight was originally made, not when imported
  scope :recent, -> { all.order(timestamp: :desc) }

  scope :spaced_repetition, -> {
    where("next_repetition_date == ? OR next_repetition_date IS NULL", Date.today)
  }

  scope :flashcard_mode, -> {
    spaced_repetition
      .order('annotation_repetitions.next_repetition_date ASC')
      .includes(:annotation_repetition).limit(1)
  }

  validates :highlighted_text, presence: true, allow_blank: false

  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
