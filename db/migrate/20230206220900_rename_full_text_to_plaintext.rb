class RenameFullTextToPlaintext < ActiveRecord::Migration[7.0]
  def change
    rename_column :books, :full_text, :plaintext
  end
end
