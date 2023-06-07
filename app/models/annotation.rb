# == Schema Information
#
# Table name: annotations
#
#  id                :integer          not null, primary key
#  highlighted_text  :text
#  notes             :text
#  start_cfi         :string
#  end_cfi           :string
#  book_id           :integer          not null
#  timestamp         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  toc_family_titles :string
#  color             :string           default("yellow")
#  starred           :boolean          default(FALSE)
#
class Annotation < ApplicationRecord
  belongs_to :book
  has_one :flashcard, dependent: :destroy

  validates :highlighted_text, presence: true, allow_blank: false

  scope :starred, -> {
    where("starred == true")
  }

  def self.ransackable_associations(auth_object = nil)
    ["flashcard", "book"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["starred", "highlighted_text", "notes", "timestamp", "toc_family_titles", "updated_at"]
  end

  # Return the chapters as an array
  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
  
end
