class LikedController < ApplicationController
  def index
    @feed = Insta.user_liked_media(session[:access_token], { max_like_id: params[:max_id] })
    @feed["pagination"]["next_max_id"] = @feed["pagination"]["next_max_like_id"]
    render 'feed/index'
  end
end
