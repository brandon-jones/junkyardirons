class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index
    @instagram_user = Instagram.new.user
  end
end
