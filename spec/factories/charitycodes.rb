FactoryBot.define do
  factory :charity_code, class: 'CharityCode' do
    code { 'CHAR' + Faker::Number.number(digits: 10).to_s }
    status { 'Active' }
    association :charity, factory: :random_charity
  end
end
