class Annotation < ApplicationRecord
  belongs_to :book

  def chapters
    JSON.parse(toc_family_titles)
  end
end
