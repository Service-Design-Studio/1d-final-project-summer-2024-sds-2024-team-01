  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    number { "9#{Faker::Number.number(digits: 7)}" }
    status { 'normal' }
    password { 'password' }
    password_confirmation { 'password' }
    association :role, factory: :random_role

    factory :random_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      number { "9#{Faker::Number.number(digits: 7)}" }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :requester do
      name { 'Harrison Ford' }
      number { "9#{Faker::Number.number(digits: 7)}" }
      email { 'harrison@example.com' }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :applicant do
      name { 'Alice Smith' }
      number { "9#{Faker::Number.number(digits: 7)}" }
      email { 'alice.smith@example.com' }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user do
      name { 'Alice Smith' }
      number { '91234567' }
      email { 'alice.smith@example.com' }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user_two do
      name { 'Jane Doe' }
      number { '81234567' }
      email { 'jane.doe@example.com' }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :dummy_user_three do
      name { 'Bob Dylan' }
      number { '98765432' }
      email { 'bob.dylan@example.com' }
      status { 'normal' }
      role_id { 1 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :admin_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      number { "90000001" }
      status { 'normal' }
      role_id { 2 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :banned_user do
      status { 'banned' }
    end

    factory :normal_user do
      status { 'normal' }
    end
  end
end
