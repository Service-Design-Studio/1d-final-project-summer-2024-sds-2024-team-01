FactoryBot.define do
  factory :user, class: 'User' do
    name { 'Testing User' }
    email { Faker::Internet.email }
    number { '91112222' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :random_user, class: 'User' do
    name { 'Random User' }
    email { Faker::Internet.email }
    number { "9#{Faker::Number.number(digits: 7)}" }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :requester, class: 'User' do
    name { 'Harrison Ford' }
    number { "9#{Faker::Number.number(digits: 7)}" }
    email { 'harrison@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :applicant, class: 'User' do
    name { 'Alice Smith' }
    number { "9#{Faker::Number.number(digits: 7)}" }
    email { 'alice.smith@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
