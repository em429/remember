class AddDefaultToFlashcards < ActiveRecord::Migration[7.0]
  def change
    change_column_default :flashcards, :easiness_factor, 2.5
    change_column_default :flashcards, :interval, 0
  end
end
