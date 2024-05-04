FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'SecurePassword!@' }

    trait :with_created_tags do
      after(:create) do |user|
        create_list(:tag, 3, user: user)
      end
    end

    trait :with_claimed_tags do
      after(:create) do |user|
        create_list(:claimed_tag, 2, user: user)
      end
    end
  end
end
