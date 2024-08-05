
FactoryBot.define do
  factory :charity do
    charity_name { Faker::Company.name }
    status { 'Inactive' }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    document_proof do
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('lib', 'assets', 'sample.pdf')),
        filename: 'sample.pdf',
        content_type: 'application/pdf'
      )
    end
    trait :active do
      status { 'Active' }
    end

    factory :random_charity do
      charity_name { Faker::Adjective.positive + ' charity' }
      status { 'Active' }
    end
  
    factory :inexpensive_charity, parent: :charity do
      charity_name { 'Inexpensive Charity' }
      status { 'Inactive' }
    end
  
    factory :tasty_charity, parent: :charity do
      charity_name { 'Tasty Charity' }
      status { 'Inactive' }
    end
  
    factory :delightful_charity, parent: :charity do
      charity_name { 'Delightful Charity' }
      status { 'Active' }
    end
  end
end
