class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition

  scope :random_all, -> { all.order('RANDOM()') }
  scope :random_single, -> { random_all.limit(1) }
  # Timestamp is when the highlight was originally made, not when imported
  scope :recent, -> { all.order(timestamp: :desc) }
  scope :spaced, -> {
    all.order('annotation_repetitions.next_repetition_date ASC').includes(:annotation_repetition).limit(1)
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
