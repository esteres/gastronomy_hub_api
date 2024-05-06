FactoryBot.define do
  factory :review do
    sequence(:title) { |n| "Review Restaurant #{n}" }
    visit_date { '2024-05-04' }
    recommendation { [:yes, :no].sample }
    rating { rand(1..5) }
    ambience_rating { rand(1..5) }
    service_rating { rand(1..5) }
    wait_time { rand(0..120) }
    value_for_money { [true, false].sample }

    user
    restaurant
  end
end
