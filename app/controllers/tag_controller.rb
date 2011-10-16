class TagController < ApplicationController
  def index
    @feed = Insta.tag_recent_media(params[:tagname], { max_tag_id: params[:max_id] })
  end

end
