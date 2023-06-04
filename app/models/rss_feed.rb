require 'rss'
require 'open-uri'

class RssFeed < ApplicationRecord
  validates :title, :url, presence: true

  def fetch
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      Rails.cache.write("#{cache_key_with_version}/cached_feed", feed, expires_in: 6.hours)
    end 
  end

  # Return the cached version, without fetching it
  def cached
    Rails.cache.fetch("#{cache_key_with_version}/cached_feed", expires_in: 6.hours)
  end

end
