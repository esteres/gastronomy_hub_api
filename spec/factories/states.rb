FactoryBot.define do
  factory :state do
    sequence(:name) { |n| "state #{n}" }
  end
end
