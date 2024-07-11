FactoryBot.define do
  factory :randomrequests do
    title { Faker::Lorem.sentence(word_count: 3) }
    category { Faker::Job.field }
    date { Faker::Date.forward(days: 30) }
    number_of_volunteers_needed { Faker::Number.between(from: 1, to: 10) }
    start_time { Faker::Time.forward(days: 30, period: :day) }
    duration { Faker::Number.between(from: 1, to: 8) }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph }
    incentive_provided { ['Money', 'Gift Card', 'Food'].sample }
    incentive_amount { Faker::Commerce.price(range: 10.0..100.0, as_string: true) }
  end
end
