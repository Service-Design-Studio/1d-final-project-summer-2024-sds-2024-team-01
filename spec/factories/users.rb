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

  factory :requester, class: 'User' do
    name { 'Harrison Ford' }
    number { '56789012' }
    email { 'harrison@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :applicant, class: 'User' do
    name { 'Alice Smith' }
    number { '12345678' }
    email { 'alice.smith@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
