FactoryBot.define do
          factory :request do
            title { "Sample Request" }
            description { "Sample Description" }
            category { "General" }
            location { "Sample Location" }
            date { Date.today }
            start_time { "10:00 AM" }
            number_of_pax { 10 }
            duration { 2 }
            reward_type { "None" }
            reward { "None" }
            status { "Available" }
            association :user, factory: :user, strategy: :build
            created_by { user.id }
            created_at { DateTime.now }
            updated_at { DateTime.now }
          end
        end
        