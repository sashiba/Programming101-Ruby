json.array! @brands do |brand|
  json.extract! brand, :id, :name, :description, :created_at, :updated_at
end

