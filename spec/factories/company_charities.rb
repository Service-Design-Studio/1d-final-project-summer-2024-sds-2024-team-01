FactoryBot.define do
  factory :random_company_charity, class: 'CompanyCharity' do
    association :company, factory: :random_company
    association :charity, factory: :random_charity
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
