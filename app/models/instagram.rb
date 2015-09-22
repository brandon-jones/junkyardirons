class Instagram < ActiveRecord::Base

  attr_accessor :user
  attr_accessor :user_id
  attr_accessor :tags

  def read_file
    file_contents = ''
    File.open(file_path, 'r') do |f|
      file_contents = f.read
    end
    file_split_contents = file_contents.split("\n")
    @user = get_file_value(file_split_contents.first)
    @user_id = get_file_value(file_split_contents[1])
    tags = get_file_value(file_split_contents.last)
    unless tags == nil
      @tags = tags.split(',').collect{|x| x.strip}
    end
    return self
  end

  def images
    instagram = Instagram.new
    tags = instagram.read_file.tags
    return @instagram_images = Instagram.where(image_tags: tags)
  end

  # def create
  #   @contact = Instagram.new(contact_params)
  #   if @contact.save
  #     flash[:success] = 'Images Updated!'
  #   else
  #     flash[:alert] = 'Images not Updated!'
  #   end
  # end

  def update_file
    user_name = @user == nil ? '' : @user
    user_id = @user_id == nil ? '' : @user_id
    tags = @tags == nil ? [] : @tags
    write_string = "user_name:#{user_name}\nuser_id:#{user_id}\ntags:#{tags}"
    File.open(file_path, 'w+') do |f|
      f.write(write_string)
    end
    return self
  end

  def tags_array
    return [] unless @tags
    return @tags
  end

  def reload_images
    Instagram.delete_all
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub("[USER ID]",Instagram.new.read_file.user_id)
    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash['meta']['code'] == 200)
        result_hash['data'].each do |result|
          # unless (result['tags'] & instagram.tags).empty?
          i = {}
          i['image_tags'] = result['tags'].join(',')
          i['created_time'] = DateTime.strptime(result['created_time'],'%s')
          i['instagram_link'] = result['link']
          i['image_id'] = result['id']
          i['low_resolution_url'] = result['images']['low_resolution']['url']
          i['thumbnail_url'] = result['images']['thumbnail']['url']
          i['standard_resolution_url'] = result['images']['standard_resolution']['url']
          i['caption'] = result['caption'] != nil ? result['caption']['text'] : nil

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
    latest_time = Instagram.first.created_time
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub('[USER ID]',Instagram.new.read_file.user_id)
    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash['meta']['code'] == 200)
        result_hash['data'].each do |result|
          # unless (result['tags'] & instagram.tags).empty?
          i = {}
          i['image_tags'] = result['tags'].join(',')
          i['created_time'] = DateTime.strptime(result['created_time'],'%s')
          i['image_id'] = result['id']
          break if i['created_time'] < latest_time  || i['image_id'] == result['id']
          i['instagram_link'] = result['link']
          i['low_resolution_url'] = result['images']['low_resolution']['url']
          i['thumbnail_url'] = result['images']['thumbnail']['url']
          i['standard_resolution_url'] = result['images']['standard_resolution']['url']
          i['caption'] = result['caption'] != nil ? result['caption']['text'] : nil

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

  def file_path
    return 'config/instagram_user_info.txt' if Rails.env == 'development'
    return ENV['APP_PATH'] + '/shared/config/instagram_user_info.txt'
  end

  def get_file_value(file_line)
    return nil unless file_line
    return file_line.split(':').last.strip
  end

  def contact_params
    params.require(:contact).permit(:tags, :created_time, :instagram_link, :low_resolution_url, :thumbnail_url, :standard_reolution_url, :caption)
  end
end