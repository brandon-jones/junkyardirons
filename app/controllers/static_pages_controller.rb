class StaticPagesController < ApplicationController

  def home
    instagram = Instagram.new
    instagram.update_images
    @instagram_images = instagram.images
    @user_id = instagram.read_file.user_id
  end

end