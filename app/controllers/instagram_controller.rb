require 'net/http'

class InstagramController < ApplicationController
  before_action :authenticated_admin?
  def edit_user
    @instagram_user = RedisModel.user_name
  end

  def search_user
    get_clients_url = $GET_CLIENTS
    get_clients_url = get_clients_url.sub("[USERNAME]",params[:user_name])
    
    result = Net::HTTP.get(URI.parse(get_clients_url))
    result_hash = JSON.parse(result)

    @results = []
    if (result_hash["meta"]["code"] == 200)
      @results = result_hash["data"]
    end
  end

  def update_user
    # instagram = Instagram.new.read_file
    params.slice('user_name', 'user_id').keys.each do |key|
      temp_hash = {}
      temp_hash['key'] = key
      temp_hash['value'] = params[key]
      RedisModel.update_value key, params[key]
    end

    Instagram.new.reload_images
    redirect_to admin_path
  end

  def edit_tags
    if RedisModel.tags
      @instagram_tags = RedisModel.tags
      @instagram_tags.join(',') if @instagram_tags.class != String
    end
    @instagram_possible_tags = Instagram.all.pluck(:image_tags).delete_if(&:empty?).collect{ |x| x.split(',')}.flatten.uniq!.sort if Instagram.all.count > 0
  end

  def update_tags
    # instagram = Instagram.new.read_file
    # instagram.tags = params["tags"]
    params.slice('tags').keys.each do |key|
      RedisModel.update_value key, params[key].split(',').collect{ |x| x.strip}.join(',')
    end
    redirect_to admin_path
  end
end
