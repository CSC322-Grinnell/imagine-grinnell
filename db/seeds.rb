# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

records = JSON.parse(File.read('db/seed_data/crops.json'))
records.each do |record|
  Crop.create!(record)
end

records = JSON.parse(File.read('db/seed_data/gardens.json'))
records.each do |record|
  Garden.create!(record)
end

records = JSON.parse(File.read('db/seed_data/produces.json'))
records.each do |record|
  Produce.create!(record)
end

records = JSON.parse(File.read('db/seed_data/users.json'))
records.each do |record|
  User.create!(record)
end