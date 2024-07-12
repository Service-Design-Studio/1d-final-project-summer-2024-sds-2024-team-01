FactoryBot.define do
  factory :random_summary_report, class: 'SummaryReport' do
    association :user, factory: :random_user
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
