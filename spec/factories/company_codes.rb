FactoryBot.define do
  factory :random_company_code, class: 'CompanyCode' do
    status { 'Active' }
    association :company, factory: :random_company
    code { 'COMP' + Faker::Number.number(digits: 10).to_s }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
