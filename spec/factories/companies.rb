FactoryBot.define do
  factory :random_company, class: 'Company' do
    company_name { Faker::Company.name }
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
    after(:create) do |company|
      create(:user, company: company, role_id: 3)
    end
    trait :active do
      status { 'Active' }
    end

    factory :friendly_company do
      company_name { 'FriendlyCompany' }
      status { 'Inactive' }
    end

    factory :grace_company do
      company_name { 'GraceCompany' }
      status { 'Inactive' }
    end

    factory :love_company do
      company_name { 'LoveCompany' }
      status { 'Active' }
    end
  end
end
