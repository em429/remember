class AddUserToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :user
  end
end
