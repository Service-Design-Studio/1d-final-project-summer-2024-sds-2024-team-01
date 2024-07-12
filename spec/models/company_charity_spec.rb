require 'rails_helper'

RSpec.describe CompanyCharity, type: :model do
  subject do
    create(:random_company_charity)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a company' do
    subject.company_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a charity' do
    subject.charity_id = nil
    expect(subject).to_not be_valid
  end
end
