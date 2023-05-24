class RenameAnnotationsRepetitionToFlashcards < ActiveRecord::Migration[7.0]
  def change
    rename_table :annotation_repetitions, :flashcards
  end
end
