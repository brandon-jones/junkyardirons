json.array!(@machines) do |machine|
  json.extract! machine, :id, :title, :description, :machine_set_id
  json.url machine_url(machine, format: :json)
end
