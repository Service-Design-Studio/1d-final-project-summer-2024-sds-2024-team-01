FactoryBot.define do
  factory :random_charity, class: 'Charity' do
    charity_name { Faker::Adjective.positive + ' Charity' }
    charity_code { 'CHAR' + Faker::Number.number(digits: 10).to_s }
    status { 'Active' }
  end
end
