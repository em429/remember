# == Schema Information
#
# Table name: rss_feeds
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rss'
require 'open-uri'

class RssFeed < ApplicationRecord
  validates :title, :url, presence: true

  # This will always refresh the feed, no matter what, unlike a Rails.cache.fetch block, which would return the cached
  # value if it's already present.
  def refresh_cache
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      Rails.cache.write("#{cache_key_with_version}/cached_feed", feed, expires_in: 6.hours)
    end 
  end

  # Return the cached version, without refresh
  def cached
    Rails.cache.fetch("#{cache_key_with_version}/cached_feed", expires_in: 6.hours)
  end

end
