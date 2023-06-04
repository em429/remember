class RssFeedFetchesController < ApplicationController
  def create
    @feed = RssFeed.find(params[:id])
    @feed.fetch

    redirect_back(fallback_location: news_path)
  end
end
