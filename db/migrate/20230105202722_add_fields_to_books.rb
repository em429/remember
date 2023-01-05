class AddFieldsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :fiction, :boolean, default: false
  end
end
