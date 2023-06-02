require 'rss'
require 'open-uri'

class RssFeed < ApplicationRecord
  validates :title, :url, presence: true

  def fetch_feed
    Rails.cache.fetch("#{cache_key_with_version}/fetch_feed", expires_in: 6.hours) do
      URI.open(url) do |rss|
        feed = RSS::Parser.parse(rss)
      end 
    end    
  end

end
