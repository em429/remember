require 'rss'
require 'open-uri'

class RssFeed < ApplicationRecord
  validates :title, :url, presence: true

  # Either fetches the feed, or returns the cached version
  def cached
    Rails.cache.fetch("#{cache_key_with_version}/cached_feed", expires_in: 6.hours) do
      URI.open(url) do |rss|
        feed = RSS::Parser.parse(rss)
      end 
    end    
  end

end
