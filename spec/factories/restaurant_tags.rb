FactoryBot.define do
  factory :restaurant_tag do
    association :restaurant
    association :tag
  end
end
