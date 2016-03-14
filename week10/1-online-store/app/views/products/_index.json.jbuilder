json.array! @products do |product|
  json.extract! product, :id, :name, :description, :created_at, :updated_at
end

