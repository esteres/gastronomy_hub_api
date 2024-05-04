FactoryBot.define do
  factory :claimed_category do
    association :user
    association :category
  end
end
