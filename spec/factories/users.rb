# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:nric) { |n| "S1234567#{n}" }
    sequence(:email) { |n| "john.doe#{n}@example.com" }
    sequence(:number) { |n| n.to_s.rjust(8, '0') } # Ensuring number is within 9 characters
    status { "active" }
    association :role
    association :charity
    association :company
    password { "password" }
    password_confirmation { "password" }

    after(:build) do |user|
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'avatar.png')), filename: 'avatar.png', content_type: 'image/png')
    end
  end
end
