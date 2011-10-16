class FollowController < ApplicationController
  def follow
    res = Insta.follow_user(session[:access_token], params[:id])
    if res["meta"]["code"] != 200
      render text: "error", status: 500
      return
    end
    render text: res["data"].to_json, content_type: 'text/javascript'
  end

  def unfollow
    res = Insta.unfollow_user(session[:access_token], params[:id])
    if res["meta"]["code"] != 200
      render text: "error", status: 500
      return
    end
    render text: res["data"].to_json, content_type: 'text/javascript'
  end
end
