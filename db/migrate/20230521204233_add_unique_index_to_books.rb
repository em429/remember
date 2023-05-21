class AddUniqueIndexToBooks < ActiveRecord::Migration[7.0]
  def change
    add_index :books, [:title, :author], unique: true
  end
end
