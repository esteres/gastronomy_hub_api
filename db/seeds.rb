# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Create 20 random users
20.times do
  random_special_char = ['!', '@', '#', '?', ']'].sample
  password = 
    Faker::Internet.password(
      min_length: 10,
      mix_case: true,
      special_characters: false
    )  + random_special_char

  User.create!(
    email: Faker::Internet.email,
    password: password
  )
end

# Generate 10 different categories
10.times do
  user = User.order("RANDOM()").first
  Category.create!(
    name: Faker::Food.unique.ethnic_category,
    description: Faker::Lorem.paragraph,
    icon_url: "https://example.com/#{Faker::Lorem.word.downcase}.png",
    priority: %w[low medium high].sample,
    active: [true, false].sample,
    is_public: [true, false].sample,
    user: user
  )
end

# Generate 10 different tags
10.times do
  user = User.order("RANDOM()").first
  Tag.create!(
    name: Faker::Food.unique.ingredient,
    description: Faker::Lorem.paragraph,
    priority: %w[low medium high].sample,
    active: [true, false].sample,
    is_public: [true, false].sample,
    user: user
  )
end
