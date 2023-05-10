class Annotation < ApplicationRecord
  belongs_to :book
  has_one :annotation_repetition

  ## Filters
  scope :filter_by_book_title, -> (title) {
    joins(:book).where("books.title like '#{title}%'") }

  scope :filter_by_fresh, -> {
    joins(:annotation_repetition).where("next_repetition_date IS NULL") }

  scope :filter_by_due, -> { 
    joins(:annotation_repetition).where("next_repetition_date >= ?", Date.today) }

  scope :filter_by_fiction, -> { 
    joins(:book).where("books.fiction == TRUE") }

  scope :filter_by_non_fiction, -> { 
    joins(:book).where("books.fiction == TRUE") }

  ## Sorts
  # Timestamp is when the highlight was originally made, not when imported
  scope :sort_by_recent, -> { order(timestamp: :desc) }
  scope :sort_by_random, -> { order("RANDOM()") }
  scope :sort_by_due_date, -> {
    joins(:annotation_repetition).order("next_repetition_date ASC") }

  ## Modes - Shortcut filter and sort combinations
  scope :flashcards_due, -> { filter_by_due.sort_by_due_date.limit(1) }
  scope :flashcards_fresh, -> { filter_by_fresh.sort_by_random.limit(1) }

  validates :highlighted_text, presence: true, allow_blank: false

  def chapters
    if toc_family_titles.present?
      JSON.parse(toc_family_titles)
    else
      nil
    end
  end
end
