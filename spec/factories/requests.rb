FactoryBot.define do
  factory :request do
    title { 'Sample Request' }
    description { 'Sample Description' }
    category { 'General' }
    location { 'Sample Location' }
    date { Date.today }
    start_time { '10:00 AM' }
    number_of_pax { 10 }
    duration { 2 }
    reward_type { 'None' }
    reward { 'None' }
    status { 'Available' }
    association :user, factory: :user, strategy: :build
    created_by { user.id }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end

  factory :test_request, class: 'Request' do
    title { 'Test Request' }
    description { 'Need someone to walk my dog for an hour every afternoon' }
    category { 'Pet Care' }
    location { 'POINT(34.052235 -118.243683)' }
    date { Date.new(2024, 7, 2) }
    number_of_pax { 1 }
    duration { 1 }
    start_time { '12:00' }
    reward { '$20' }
    reward_type { 'Cash' }
    status { 'Open' }
    association :created_by, factory: :user, name: 'Harrison Ford'
  end
end
