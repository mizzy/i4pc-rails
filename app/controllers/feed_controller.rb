class FeedController < ApplicationController
  def index
    unless  session[:username]
      @popular = Insta.media_popular
      render template: "popular/index"
      return
    end

    @feed = Insta.user_media_feed(session[:access_token], { max_id: params[:max_id] })

    @feed["data"].each do |media|
      key = sprintf("user_has_liked_%s_%s", session[:access_token], media["id"])
      if !media["user_has_liked"] and InstaCache.get(key)
        media["user_has_liked"] = true
        media["likes"]["count"] = media["likes"]["count"] + 1
      end
    end
  end
end
