require 'net/http'

class InstagramController < ApplicationController

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
    @instagram_possible_tags = Instagram.all.pluck(:image_tags).delete_if(&:empty?).collect{ |x| x.split(',')}.flatten.uniq!.sort.join(', ') if Instagram.all.count > 0
  end

  def update_tags
    # instagram = Instagram.new.read_file
    # instagram.tags = params["tags"]
    params.slice('tags').keys.each do |key|
      temp_hash = {}
      temp_hash['key'] = key
      temp_hash['value'] = params[key]
      RedisModel.update_value key, params[key]
    end
    redirect_to admin_path
  end

  # def get_images
  #   # if params["next_id"] == "0"
  #     instagram = Instagram.new
  #     instagram_images = []
  #     instagram_images_url = $GET_CLIENT_IMAGES
  #     instagram_images_url = instagram_images_url.sub("[USER ID]",params['user_id'])
  #     result = Net::HTTP.get(URI.parse(instagram_images_url))
  #     result_hash = JSON.parse(result)
  #     if (result_hash["meta"]["code"] == 200)
  #       result_hash["data"].each do |result|
  #         unless (result["tags"] & instagram.tags).empty?
  #           instagram_images.push(result)
  #         end
  #       end
  #     end
  #     @return_results = {}
  #     @return_results["pagination"] = result_hash["pagination"]
  #     @return_results["data"] = instagram_images
      
  #     binding.pry
  #   # end
  #   # respond_to do |format|
  #   #   format.json { render :show, status: :created, image_hash: @instagram_images }
  #   # end

  #   binding.pry
  #   respond_to do |format|
  #     format.html do
  #         render partial: 'show', locals: { picture: @picture } and return
  #     end
  #     format.json { render json: @picture.to_json(:methods => [:thumbnail,:medium, :large])}
  #   end
  # end
end
