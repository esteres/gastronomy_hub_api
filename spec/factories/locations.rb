FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    sequence(:zip_code) { |n| "ZIP #{n}" }

    restaurant
    city
    state
    country
  end
end
