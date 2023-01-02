class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.text :highlighted_text
      t.text :notes
      t.string :start_cfi
      t.string :end_cfi
      t.references :book, null: false, foreign_key: true
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
