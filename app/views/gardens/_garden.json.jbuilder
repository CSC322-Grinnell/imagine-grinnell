json.extract! garden, :id, :garden_name, :address, :lat, :long, :contact_name, :phone_number, :email, :created_at, :updated_at
json.url garden_url(garden, format: :json)
