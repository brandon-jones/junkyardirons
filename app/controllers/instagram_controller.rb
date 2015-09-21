class InstagramController < ApplicationController

  def edit_user
    @instagram = Instagram.new
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
    instagram = Instagram.new
    instagram.user_id = params["user_id"]
    instagram.user = params["user_name"]
    instagram.save
    redirect_to admin_path
  end

  def edit_tags
    @instagram = Instagram.new
  end

  def update_tags
    instagram = Instagram.new
    instagram.tags = params["tags"]
    instagram.save
    redirect_to admin_path
  end
end
