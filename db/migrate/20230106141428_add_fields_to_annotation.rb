class AddFieldsToAnnotation < ActiveRecord::Migration[7.0]
  def change
    add_column :annotations, :toc_family_titles, :string
  end
end
