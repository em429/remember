class AddStarredToAnnotations < ActiveRecord::Migration[7.0]
  def change
    add_column :annotations, :starred, :boolean, default: false
  end
end
