FactoryBot.define do
  factory :claimed_tag do
    association :user
    association :tag
  end
end
