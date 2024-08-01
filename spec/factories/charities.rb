FactoryBot.define do
  factory :random_charity, class: 'Charity' do
    charity_name { Faker::Adjective.positive + ' charity' }
    status { 'Active' }
    document_proof do
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('lib', 'assets', 'sample.pdf')),
        filename: 'sample.pdf',
        content_type: 'application/pdf'
      )
    end
  end
end
