class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index
    # instagram = Instagram.new.read_file
    @instagram_user = StaticInfo.user_name != nil ? StaticInfo.user_name.value : nil
    @instagram_tags = StaticInfo.tags != nil ? StaticInfo.tags.value : nil
  end
end
