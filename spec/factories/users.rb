FactoryBot.define do
  factory :user do
    name { 'Testing User' }
    nric { 'T1234567J' }
    email { Faker::Internet.email }
    number { '91112222' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
