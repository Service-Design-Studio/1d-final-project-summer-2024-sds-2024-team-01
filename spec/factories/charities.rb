FactoryBot.define do
  factory :charity do
    charity_name { "Sample Charity" }
    charity_code { "SC12345" }
    status { "active" }
  end
end
