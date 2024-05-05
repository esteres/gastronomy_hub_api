FactoryBot.define do
  factory :restaurant_category do
    association :restaurant
    association :category
  end
end
