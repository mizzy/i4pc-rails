class AuthController < ApplicationController
  def login
    redirect_to Instagram.authorize_url(
        scope:        'likes comments relationships',
        redirect_uri: INSTAGRAM_CALLBACK_URL,
    )
  end

  def auth
    res = Instagram.get_access_token(params[:code], :redirect_uri => INSTAGRAM_CALLBACK_URL)
    session[:access_token] = res["access_token"]
    client = Instagram.client(:access_token => session[:access_token])
    session[:username]        = client.user["username"]
    session[:user_id]         = client.user["id"]
    session[:profile_picture] = client.user["profile_picture"]
    redirect_to feed_url
  end

  def logout
    session[:username]        = nil
    session[:user_id]         = nil
    session[:profile_picture] = nil
    session[:access_token]    = nil
  end

end
