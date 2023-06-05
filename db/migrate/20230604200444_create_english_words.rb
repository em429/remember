class CreateEnglishWords < ActiveRecord::Migration[7.0]
  def change
    create_table :english_words do |t|
      t.string :word, required: true
      t.text :definition_wordnet, default: nil

      t.timestamps
    end

    add_index :english_words, :word, unique: true
  end
end
