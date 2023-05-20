class MakeHighlightTextUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :annotations, :highlighted_text, unique: true
  end
end
