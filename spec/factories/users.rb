FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    number { "9#{Faker::Number.number(digits: 7)}" }
    status { 'Active' }
    password { 'password' }
    password_confirmation { 'password' }
    association :role, factory: :random_role

    trait :admin do
      role_id { 2 } # Assuming 2 is the role ID for admin
    end

    factory :random_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      number { "9#{Faker::Number.number(digits: 7)}" }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :requester do
      name { 'Harrison Ford' }
      number { "9#{Faker::Number.number(digits: 7)}" }
      email { 'harrison@example.com' }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :applicant do
      name { 'Alice Smith' }
      number { "9#{Faker::Number.number(digits: 7)}" }
      email { 'alice.smith@example.com' }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user do
      name { 'Alice Smith' }
      number { '91234567' }
      email { 'alice.smith@example.com' }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user_two do
      name { 'Jane Doe' }
      number { '81234567' }
      email { 'jane.doe@example.com' }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user_three do
      name { 'Bob Dylan' }
      number { '98765432' }
      email { 'bob.dylan@example.com' }
      status { 'Active' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :admin_user, traits: [:admin] do
      email { 'admin@example.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end
    factory :millard_robel do
      name { 'Millard Robel' }
      email { 'millard.robel@example.com' }
      number { '90000002' }
      status { 'Active' }
      password { 'password' }
      password_confirmation { 'password' }
      role_id { 1 }
    end
  end
end
