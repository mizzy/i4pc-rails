class PhotoController < ApplicationController
  def show
    @media    = Insta.media_item(session[:access_token], params[:id])
    @likers   = Insta.media_likes(session[:access_token], params[:id])
    @comments = Insta.media_comments(session[:access_token], params[:id])
  end
end
