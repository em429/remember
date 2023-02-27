class Annotation < ApplicationRecord
  belongs_to :book

  scope :random_all, -> { all.order('RANDOM()') }
  scope :random_single, -> { random_all.limit(1) }
  scope :recent, -> { all.order(timestamp: :desc) }

  validates :highlighted_text, presence: true, allow_blank: false

  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
