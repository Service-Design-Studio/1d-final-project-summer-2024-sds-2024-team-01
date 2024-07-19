FactoryBot.define do
  factory :application, class: 'RequestApplication' do
    transient do
      userid { 0 }
      requestid { 0 }
    end

    trait :pending do
      status { 'Pending' }
    end
    trait :completed do
      status { 'Completed' }
    end
    trait :unfulfilled do
      status { 'Unfulfilled' }
    end
    applicant_id { userid }
    request_id { requestid }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end

  factory :random_application, class: 'RequestApplication' do
    trait :pending do
      status { 'Pending' }
    end
    trait :completed do
      status { 'Completed' }
    end
    trait :unfulfilled do
      status { 'Unfulfilled' }
    end
    association :applicant, factory: :random_user
    association :request, factory: :requestwiththumbnail
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
