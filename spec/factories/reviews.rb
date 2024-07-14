FactoryBot.define do
  factory :review, class: 'Review' do
    rating { Faker::Number.between(from: 1, to: 5) }
    review_content { Faker::Quote.famous_last_words }
    association :request, factory: :test_request, strategy: :build
    association :review_for, factory: :random_user, strategy: :build
    association :review_by, factory: :random_user, strategy: :build
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
