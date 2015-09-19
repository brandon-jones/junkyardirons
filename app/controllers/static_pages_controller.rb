class StaticPagesController < ApplicationController

  def home
    # Scraper.scrape_all
    # @saved_searches = current_user ? current_user.saved_searches : []
    # @all_job_searches = JobSearch.all
    instagram = Instagram.new

    @instagram_images = []
    instagram_images_url = $GET_CLIENT_IMAGES
    instagram_images_url = instagram_images_url.sub("[USER ID]",instagram.user_id)
    begin
      result = Net::HTTP.get(URI.parse(instagram_images_url))
      result_hash = JSON.parse(result)
      if (result_hash["meta"]["code"] == 200)
        result_hash["data"].each do |result|
          if result["tags"].include?('tattoomachine')
            @instagram_images.push(result)
          end
        end
      end
      puts result_hash["pagination"]
      if result_hash["pagination"] && result_hash["pagination"]["next_url"]
        instagram_images_url = result_hash["pagination"]["next_url"]
      end
    end while result_hash["pagination"] && result_hash["pagination"]["next_url"]
  end

end