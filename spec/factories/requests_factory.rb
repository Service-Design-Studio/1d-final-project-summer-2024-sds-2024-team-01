FactoryBot.define do
  factory :random_request, class: 'Request' do
    title { Faker::Lorem.sentence(word_count: 3) }
    category { ["Manual labour", "Teaching", "Delivery"].sample }
    date { Faker::Date.forward(days: 1) }
    number_of_pax { Faker::Number.between(from: 1, to: 10) }
    start_time { Faker::Time.forward(days: 1, period: :day) }
    duration { Faker::Number.between(from: 1, to: 8) }
    location { generate_random_location }
    description { Faker::Lorem.paragraph }
    reward_type { ['Money', 'Gift Card', 'Food'].sample }
    reward { Faker::Commerce.price(range: 10.0..100.0, as_string: true) }
    status { 'Pending' }
    association :user, factory: :user
  end
end

def generate_random_location
  latitude = Faker::Address.latitude
  longitude = Faker::Address.longitude
  "POINT(#{latitude} #{longitude})"
end