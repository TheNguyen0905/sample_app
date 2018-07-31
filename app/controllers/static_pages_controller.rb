class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.lastest.page(params[:page])
        .per Settings.user_feed_paninate
    end
  end

  def help; end

  def about; end
end
