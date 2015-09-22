class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index
    instagram = Instagram.new.read_file
    @instagram_user = instagram.user
    @instagram_tags = instagram.tags != nil ? instagram.tags.join(',') : instagram.tags
  end
end
