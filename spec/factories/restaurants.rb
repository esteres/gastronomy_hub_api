FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant #{n}" }
    description { 'Restaurant description' }
    contact_information_type { :phone }
    contact_information { '3545678991' }
  end
end
