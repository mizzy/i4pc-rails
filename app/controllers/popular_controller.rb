class PopularController < ApplicationController
  def index
    @popular = Insta.media_popular
  end
end
