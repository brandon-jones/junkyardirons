class StaticPagesController < ApplicationController

  def home
    instagram = Instagram.new
    instagram.update_images
    @instagram_images = instagram.images
    @user_id = RedisModel.user_id
  end

end