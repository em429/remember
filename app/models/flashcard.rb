class Flashcard < ApplicationRecord
  belongs_to :annotation
  # TODO add validations

  def self.ransackable_attributes(auth_object = nil)
    ["annotation_id", "created_at", "easiness_factor", "id", "interval", "next_repetition_date", "updated_at"]
  end  

  # scope :unscored, -> { # Cards that haven't been scored yet
  #   where("next_repetition_date IS NULL") }

  # scope :due, -> { # Cards that are either due today, or are overdue
  #   where("next_repetition_date <= ?", Date.today) }

  # scope :order_by_due_first, -> {
  #   order("next_repetition_date ASC")
  # }
  # scope :order_by_random, -> { order("RANDOM()") }

  scope :scored_today, -> { # Cards scored today
    where("next_repetition_date IS NOT NULL").where(updated_at: Time.current.all_day)
  }

end
