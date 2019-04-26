json.extract! garden, :id, :name, :address, :lat, :long, :contact_name, :contact_number, :email, :created_at, :updated_at, :image, :notes
json.url garden_url(garden, format: :json)
