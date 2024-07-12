FactoryBot.define do
  factory :random_company, class: 'Company' do
    company_name { Faker::Adjective.positive + 'Company' }
    status { 'Active' }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end

