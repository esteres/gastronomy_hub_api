FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }
    description { 'Tag description' }
    priority { :low }
    active { true }
    is_public { true }

    user
  end
end
