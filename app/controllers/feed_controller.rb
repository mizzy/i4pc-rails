class FeedController < ApplicationController
  def index
    unless  session[:username]
      @popular = Insta.media_popular
      render template: "popular/index"
      return
    end

    @feed = Insta.user_media_feed(session[:access_token], { max_id: params[:max_id] })
  end
end
