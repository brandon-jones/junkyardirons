json.array!(@machine_sets) do |machine_set|
  json.extract! machine_set, :id, :title, :description, :price, :quantity, :image_url
  json.url machine_set_url(machine_set, format: :json)
end
