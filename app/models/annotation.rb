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


  # Imports annotations from a Calibre metadata.opf file into db and creates "unscored"
  # Flashcard rows as well for each Annotation.
  def self.batch_import(book_id, opf_file)
    metadata_hashes = calibre_metadata_to_json(opf_file)
    metadata_hashes.each do |hash|
      annotation_hash = hash['annotation']
      highlight_color = annotation_hash["style"]["which"]

      next if annotation_hash['highlighted_text'].blank?
      begin
        annotation = create!(
          highlighted_text: normalize_text(annotation_hash['highlighted_text']),
          color: highlight_color,
          notes: annotation_hash['notes'],
          start_cfi: annotation_hash['start_cfi'],
          end_cfi: annotation_hash['end_cfi'],
          timestamp: annotation_hash['timestamp'],
          toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
          book_id: book_id
        )
      # For easy updates: if highlight is a duplicate, simply skip adding it.
      rescue ActiveRecord::RecordNotUnique
        next
      end

      # TODO: what if I don't add Flashcards by default? But instead put this on a button somewhere, with a setting
      # for how many flashcards I want to make from annotations, what order, which books ..etc ?
      #   + I could also set the next_repetition_date to be today by default, then, not nil.
      
      # Create an unscored Flashcard with the default values
      Flashcard.create_with_defaults(annotation)
    end
  end
  
  # Return the chapters as an array
  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end

  def add_star
    update(starred: true)
    save
  end

  def remove_star
    update(starred: false)
    save
  end
  
end
