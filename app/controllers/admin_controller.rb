class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index
    instagram = Instagram.new
    @instagram_user = instagram.user
    @instagram_tags = instagram.tags.join(',')
  end
end
