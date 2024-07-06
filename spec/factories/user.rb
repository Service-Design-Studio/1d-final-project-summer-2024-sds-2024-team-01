# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    name { "Test User" }
  end
end

# spec/factories/requests.rb
FactoryBot.define do
  factory :request do
    title { "Test Request" }
    category { "Category" }
    location { "Location" }
    date { Date.today }
    number_of_pax { 5 }
    duration { 3 }
    reward { 100 }
    reward_type { "Cash" }
    status { "Available" }
    created_by { association :user }
  end
end
