FactoryBot.define do
  factory :random_application, class: 'RequestApplication' do
    trait :pending do
      status {'Pending'}
    end
    trait :completed do
      status {'Completed'}
    end
    trait :unfulfilled do
      status {'Unfulfilled'}
    end
    association :applicant, factory: :random_user
    association :request, factory: :test_request
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
