class CommentController < ApplicationController
  def post
    res = Insta.create_media_comment(session[:access_token], params[:id], params[:comment_text])
    if res
      render text: "OK"
    else
      render text: "error", status: 500
    end
  end
end
