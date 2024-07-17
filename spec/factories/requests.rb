FactoryBot.define do
  factory :request do
    title { "Help with #{Faker::Verb.ing_form} #{Faker::Hacker.noun}" }
    description { Faker::Quote.fortune_cookie }
    category { 'General' }
    location { "POINT(#{Faker::Number.between(from: 103.8, to: 104.0).round(3)} #{Faker::Number.between(from: 1.30, to: 1.40).round(3)})" }
    date { Faker::Date.forward(from: Date.tomorrow, days: 90) }
    start_time { '10:00 AM' }
    number_of_pax { Faker::Number.between(from: 1, to: 10) }
    duration { 2 }
    reward_type { 'None' }
    reward { 'None' }
    status { 'Available' }
    association :user, factory: :random_user, strategy: :build
    created_at { DateTime.now }
    updated_at { DateTime.now }
    thumbnail { ActiveStorage::Blob.create_and_upload!( 
        io: File.open(Rails.root.join('app', 'assets', 'images', 'freepik-lmao.jpg')),
        filename: 'my_image.jpg',
        content_type: 'image/jpeg'
    )}

    # after(:build) do |request|
    #   image_path =       request.thumbnail.attach(
    #   )
    # end
  end

  factory :test_request, class: 'Request' do
    title { 'Test Request' }
    description { 'Need someone to walk my dog for an hour every afternoon' }
    category { 'Pet Care' }
    location { 'POINT(34.052235 -118.243683)' }
    date { Date.tomorrow }
    number_of_pax { 1 }
    duration { 1 }
    start_time { '12:00' }
    reward { '$20' }
    reward_type { 'Cash' }
    status { 'Open' }
    association :user, factory: :random_user, strategy: :build
  end
end
