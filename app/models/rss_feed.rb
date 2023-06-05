require 'rss'
require 'open-uri'

class RssFeed < ApplicationRecord
  validates :title, :url, presence: true

  # TODO: rename to 'refresh?' fetch is confusing because of cache.fetch method which does soemthing else than this.
  # This will always refresh the feed, no matter what, unlike a Rails.cache.fetch block, which would return the cached
  # value if it's already present.
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
