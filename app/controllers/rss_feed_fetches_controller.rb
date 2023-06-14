class RssFeedFetchesController < ApplicationController
  def create
    @feed = RssFeed.find(params[:id])
    @feed.refresh_cache

    redirect_back(fallback_location: news_path)
  end
end
