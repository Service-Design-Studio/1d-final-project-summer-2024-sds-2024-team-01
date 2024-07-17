FactoryBot.define do
  factory :reviewrequester, class: 'Review' do
    rating { Faker::Number.between(from: 1, to: 5) }
    review_content { Faker::Quote.famous_last_words }
    association :review_for, factory: :random_user, strategy: :build
    association :review_by, factory: :random_user, strategy: :build
    association :request, factory: :test_request, created_by: :review_for
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end

  factory :reviewapplicant, class: 'Review' do
    rating { Faker::Number.between(from: 1, to: 5) }
    review_content { Faker::Quote.famous_last_words }
    association :review_for, factory: :random_user, strategy: :build
    association :review_by, factory: :random_user, strategy: :build
    association :request, factory: :test_request, created_by: :review_by
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
