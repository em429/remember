class CreateNewsFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :news_feeds do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
    add_index :news_feeds, :title, unique: true
    add_index :news_feeds, :url, unique: true
  end
end
