FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    description { 'Category description' }
    icon_url { 'https://example.com/icon.png' }
    priority { :low }
    active { true }
    is_public { true }

    user
  end
end
