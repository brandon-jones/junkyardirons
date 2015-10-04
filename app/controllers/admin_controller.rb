class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index
    # instagram = Instagram.new.read_file
    @instagram_user = RedisModel.user_name
    @instagram_tags = RedisModel.tags.split(',').join(', ')
    @signups_enabled = to_bool(RedisModel.signups_enabled)
  end

  def update_signup_status
    RedisModel.update_value 'signups_enabled', params['signups_enabled']
  end
end
