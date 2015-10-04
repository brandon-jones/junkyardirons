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
    if tags
      Instagram.all.each do |image|
        if (image['image_tags'].split(',') & tags).count > 0
          @image_array.push image
        end
      end
    end
    return @image_array
  end

  def standard_resolution_width
    return self.standard_resolution_size.split(',')[0]
  end

  def standard_resolution_height
    return self.standard_resolution_size.split(',')[1]
  end

  def reload_images
    Instagram.delete_all
    image_scrape
  end

  def update_images
    image_scrape
  end

  private

  def image_scrape
    return unless RedisModel.user_id != nil
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub("[USER ID]",RedisModel.user_id)

    most_recent_instgram_image = Instagram.order(created_time: :desc).first if Instagram.count > 0
    latest_time = most_recent_instgram_image == nil ? nil : most_recent_instgram_image.created_time
    latest_time = DateTime.now - 20.years if latest_time == nil
    latest_id = most_recent_instgram_image == nil ? nil : most_recent_instgram_image.image_id

    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash['meta']['code'] == 200)
        result_hash['data'].each do |result|
          i = get_image_hash(result)
          return if i['created_time'] < latest_time  || i['image_id'] == latest_id
          instagram = Instagram.new i
          instagram.save
        end
      end
      puts result_hash['pagination']
      if result_hash['pagination'] && result_hash['pagination']['next_url']
        instagram_images_url = result_hash['pagination']['next_url']
      end
    end while result_hash['pagination'] && result_hash['pagination']['next_url']
  end

  def get_image_hash(image_hash)
    image = {}
    image['image_tags'] = image_hash['tags'].join(',')
    image['created_time'] = DateTime.strptime(image_hash['created_time'],'%s')
    image['image_id'] = image_hash['id']
    image['instagram_link'] = image_hash['link']
    image['low_resolution_url'] = image_hash['images']['low_resolution']['url']
    image['low_resolution_size'] = image_hash['images']['low_resolution']['width'].to_s + ',' + image_hash['images']['low_resolution']['height'].to_s
    image['thumbnail_url'] = image_hash['images']['thumbnail']['url']
    image['thumbnail_size'] = image_hash['images']['thumbnail']['width'].to_s + ',' + image_hash['images']['thumbnail']['height'].to_s
    image['standard_resolution_url'] = image_hash['images']['standard_resolution']['url']
    image['standard_resolution_size'] = image_hash['images']['standard_resolution']['width'].to_s + ',' + image_hash['images']['standard_resolution']['height'].to_s
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
    params.require(:contact).permit(:tags, :created_time, :instagram_link, :low_resolution_url, :thumbnail_url, :standard_reolution_url, :caption, :thumbnail_size, :low_resolution_size, :standard_size)
  end
end