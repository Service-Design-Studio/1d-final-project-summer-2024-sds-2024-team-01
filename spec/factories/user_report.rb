FactoryBot.define do
  factory :random_user_report, class: 'UserReport' do
    report_reason { Faker::Quote.fortune_cookie }
    status { 'under_review' }
    created_at { DateTime.now }
    updated_at { DateTime.now }

    association :reported_by, factory: :random_user
    association :reported_user, factory: :random_user
  end
end
