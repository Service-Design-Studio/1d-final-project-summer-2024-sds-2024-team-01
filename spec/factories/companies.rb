FactoryBot.define do
  factory :random_company, class: 'Company' do
    company_name { Faker::Adjective.positive + 'Company' }
    status { 'Pending' }
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
  end
end