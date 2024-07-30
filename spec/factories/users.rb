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
  factory :admin_user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    number { "90000001" }
    status { 'Active' }
    role_id { Role.find_or_create_by!(role_name: 'Admin').id }
    password { 'password' }
    password_confirmation { 'password' }
  end
  FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    number { "9#{Faker::Number.number(digits: 7)}" }
    password { 'password' }
    password_confirmation { 'password' }
    status { 'Active' }
    association :role, factory: :user_role
    association :company

    factory :admin_user do
      association :role, factory: :admin_role
    end

    factory :banned_user do
      status { 'banned' }
    end

    factory :normal_user do
      status { 'normal' }
    end
  end