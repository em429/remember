class RenameNewsFeedsToRssFeeds < ActiveRecord::Migration[7.0]
  def change
    rename_table :news_feeds, :rss_feeds
  end
end
