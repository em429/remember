class NewsFeedController < ApplicationController
  def index
    # FIXME: replace the below title matching w/ something better
    @best = NewsFeed.where(title: "HN Best").first
    @classic = NewsFeed.where(title: "HN Classic").first
    @most_commented = NewsFeed.where(title: "HN Most Commented").first
  end
end
