class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_token

  protected

  def check_token
    return unless cookies[:username]
    return unless session[:access_token]

    client = Instagram.client(:access_token => session[:access_token])
    if cookies[:username] != client.user["username"]
      session[:username]        = nil
      session[:user_id]         = nil
      session[:profile_picture] = nil
      session[:access_token]    = nil
    end
  end

end
