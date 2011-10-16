class LikeController < ApplicationController
  def like
    res = Insta.like_media(session[:access_token], params[:id])
    if res["meta"]["code"] != 200
      render text: "error", status: 500
      return
    end
  end

  def unlike
    res = Insta.unlike_media(session[:access_token], params[:id])
    if res["meta"]["code"] != 200
      render text: "error", status: 500
      return
    end
  end
end
