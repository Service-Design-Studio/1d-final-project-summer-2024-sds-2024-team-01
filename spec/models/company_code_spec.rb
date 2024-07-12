require 'rails_helper'

RSpec.describe CompanyCode, type: :model do
  subject do
    create(:random_company_code)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a company' do
    subject.company_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end
end
