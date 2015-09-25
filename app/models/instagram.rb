class Instagram < ActiveRecord::Base

  # def read_file
  #   file_contents = ''
  #   File.open(file_path, 'r') do |f|
  #     file_contents = f.read
  #   end
  #   file_split_contents = file_contents.split("\n")
  #   @user = get_file_value(file_split_contents.first)
  #   @user_id = get_file_value(file_split_contents[1])
  #   tags = get_file_value(file_split_contents.last)
  #   unless tags == nil
  #     @tags = tags.split(',').collect{|x| x.strip}
  #   end
  #   return self
  # end

  def images
    tags = RedisModel.tags
    tags = tags.split(',') unless tags.class == Array || tags == nil || tags.empty?
    @image_array = []
    Instagram.all.each do |image|
      if (image['image_tags'].split(',') & tags).count > 0
        @image_array.push image
      end
    end
    return @image_array
  end

  # def create
  #   @contact = Instagram.new(contact_params)
  #   if @contact.save
  #     flash[:success] = 'Images Updated!'
  #   else
  #     flash[:alert] = 'Images not Updated!'
  #   end
  # end

  # def update_file
  #   user_name = @user == nil ? '' : @user
  #   user_id = @user_id == nil ? '' : @user_id
  #   tags = @tags == nil ? [] : @tags
  #   tags = tags.join(',') unless tags.class == String
  #   write_string = "user_name:#{user_name}\nuser_id:#{user_id}\ntags:#{tags}"
  #   File.open(file_path, 'w+') do |f|
  #     f.write(write_string)
  #   end
  #   return self
  # end

  # def tags_array
  #   return @tags
  # end

  def reload_images
    return unless RedisModel.user_id
    Instagram.delete_all
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub("[USER ID]",RedisModel.user_id)
    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash['meta']['code'] == 200)
        result_hash['data'].each do |result|
          # unless (result['tags'] & instagram.tags).empty?
          i = get_image_hash(result)

          instagram = Instagram.new i
          instagram.save
          #   @instagram_images.push(result)
          # end
        end
      end
      puts result_hash['pagination']
      if result_hash['pagination'] && result_hash['pagination']['next_url']
        instagram_images_url = result_hash['pagination']['next_url']
      end
    end while result_hash['pagination'] && result_hash['pagination']['next_url']
  end

  def update_images
    return unless RedisModel.user_id != nil
    latest_time = Instagram.first.created_time if Instagram.first
    latest_time = DateTime.now - 20.years if latest_time == nil
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub('[USER ID]',RedisModel.user_id)
    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash['meta']['code'] == 200)
        result_hash['data'].each do |result|
          # unless (result['tags'] & instagram.tags).empty?
          i = get_image_hash(result)
          return if i['created_time'] < latest_time  || i['image_id'] == result['id']

          instagram = Instagram.new i
          instagram.save
          #   @instagram_images.push(result)
          # end
        end
      end
      puts result_hash['pagination']
      if result_hash['pagination'] && result_hash['pagination']['next_url']
        instagram_images_url = result_hash['pagination']['next_url']
      end
    end while result_hash['pagination'] && result_hash['pagination']['next_url']
  end

  private

  def get_image_hash(image_hash)
    image = {}
    image['image_tags'] = image_hash['tags'].join(',')
    image['created_time'] = DateTime.strptime(image_hash['created_time'],'%s')
    image['image_id'] = image_hash['id']
    image['instagram_link'] = image_hash['link']
    image['low_resolution_url'] = image_hash['images']['low_resolution']['url']
    image['thumbnail_url'] = image_hash['images']['thumbnail']['url']
    image['standard_resolution_url'] = image_hash['images']['standard_resolution']['url']
    image['caption'] = image_hash['caption'] != nil ? image_hash['caption']['text'] : nil
    return image
  end

  # def file_path
  #   return 'config/instagram_user_info.txt' if Rails.env == 'development'
  #   return ENV['APP_PATH'] + '/shared/config/instagram_user_info.txt'
  # end

  def get_file_value(file_line)
    return nil unless file_line
    return file_line.split(':').last.strip
  end

  def contact_params
    params.require(:contact).permit(:tags, :created_time, :instagram_link, :low_resolution_url, :thumbnail_url, :standard_reolution_url, :caption)
  end
end