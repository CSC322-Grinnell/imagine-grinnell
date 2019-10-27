json.extract! volunteer, :id, :email, :password, :salt, :created_at, :updated_at
json.url volunteer_url(volunteer, format: :json)
