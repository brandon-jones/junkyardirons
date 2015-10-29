json.array!(@images) do |image|
  json.extract! image, :id, :public_id, :width, :height, :format, :bytes, :url, :secure_url, :imageable_id, :imageable_type
  json.url image_url(image, format: :json)
end
