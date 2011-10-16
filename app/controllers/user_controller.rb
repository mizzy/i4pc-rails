class UserController < ApplicationController
  def show
    if not session[:access_token]
      redirect_to login_url
      return
    end

    @user = Insta.user_find_by_username(session[:access_token], params[:username])
    if not @user
      @message = "User not found."
      render template: 'error/error', status: 404
      return
    end
    
    if not @user["counts"]
      @private = true
    end

    if @private
      @feed               = {}
      @feed["pagination"] = {}

      @user["counts"] = {}

      @follows = []
    else
      @feed = Insta.user_recent_media(session[:access_token], @user["id"], { max_id: params[:max_id] })
      @follows = Insta.user_follows(session[:access_token], @user["id"], { count: 2000 })
    end
    @relationship = Insta.user_relationship(session[:access_token], @user["id"])

  end
end
