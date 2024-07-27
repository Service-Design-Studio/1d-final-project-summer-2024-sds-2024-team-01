FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    number { "9#{Faker::Number.number(digits: 7)}" }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :random_user, class: 'User' do
    name { Faker::Name.name }
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

  factory :dummy_user, class: 'User' do
    name { 'Alice Smith' }
    number { '91234567' }
    email { 'alice.smith@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :dummy_user_two, class: 'User' do
    name { 'Jane Doe' }
    number { '81234567' }
    email { 'jane.doe@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :dummy_user_three, class: 'User' do
    name { 'Bob Dylan' }
    number { '98765432' }
    email { 'bob.dylan@example.com' }
    status { 'Active' }
    role_id { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end
  factory :dummy_user_four, class: 'Admin' do
    name { 'Timothy Lee' }
    number { '90000000' }
    email { 'timothy.lee@example.com' }
    status { 'Active' }
    role_id { 2 }
    password { 'password' }
    password_confirmation { 'password' }
    end
  end