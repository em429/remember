class CreateAnnotationRepetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :annotation_repetitions do |t|
      t.references :annotation, null: false, foreign_key: true
      t.date :next_repetition_date
      t.integer :interval
      t.float :easiness_factor

      t.timestamps
    end
  end
end
