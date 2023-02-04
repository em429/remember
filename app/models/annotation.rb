class Annotation < ApplicationRecord
  belongs_to :book

  scope :random_all, -> { all.order('RANDOM()') }
  scope :random_single, -> { random_all.limit(1) }
  scope :recent, -> { all.order(timestamp: :desc) }

  def chapters
    JSON.parse(toc_family_titles)
  end
end
