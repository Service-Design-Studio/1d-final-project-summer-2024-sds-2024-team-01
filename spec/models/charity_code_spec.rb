require 'rails_helper'

RSpec.describe CharityCode, type: :model do
  subject do
    create(:charity_code)
  end

  it 'is not valid without a name' do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a charity' do
    subject.charity_id = nil
    expect(subject).to_not be_valid
  end
end
