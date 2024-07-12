require 'rails_helper'

RSpec.describe Company, type: :model do
  subject do
    create(:random_company)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.company_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end
end
