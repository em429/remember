class RssFeedsController < ApplicationController
  def index
    @rss_feed = RssFeed.all
  end

  def new
    @rss_feed = RssFeed.new
  end

  def create
    @rss_feed = RssFeed.new(rss_feed_params)
    if @rss_feed.save
      redirect_to rss_feeds_path, notice: "RSS feed successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @rss_feed = RssFeed.find(params[:id])
  end

  def update
    @rss_feed = RssFeed.find(params[:id])
    if @rss_feed.update(rss_feed_params)
      redirect_to rss_feeds_path, notice: "RSS feed succesfully updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @rss_feed = RssFeed.find(params[:id])
    @rss_feed.destroy
    redirect_to rss_feeds_path
  end

  private

  def rss_feed_params
    params.require(:rss_feed).permit(:title, :url)
  end

end
