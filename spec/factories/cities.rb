FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "city #{n}" }
  end
end
