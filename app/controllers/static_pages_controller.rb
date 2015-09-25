class StaticPagesController < ApplicationController

  def home
    instagram = Instagram.new
    instagram.update_images
    @instagram_images = instagram.images
    @user_id = StaticInfo.user_id != nil ? StaticInfo.user_id.value : nil
  end

end