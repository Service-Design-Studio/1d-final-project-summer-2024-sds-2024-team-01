# spec/factories/requests.rb
FactoryBot.define do
          factory :request do
            association :user
            title { "Test Title" }
            category { "Teaching" }
            location { "Test Location" }
            date { Date.today }
            number_of_pax { 3 }
            duration { 4 }
            reward_type { "Yes" }
            status { "Pending" }
            created_by { "User ID or Name" }
            start_time { "10:00" }
            end_time { "14:00" }
            description { "Test description" }
            reward { "Yes" }
            reward_description { "Free lunch" }
          end
        end
        