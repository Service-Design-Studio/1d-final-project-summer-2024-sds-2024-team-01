require 'rails_helper'

RSpec.describe Chat, type: :model do
  subject do
    create(:random_chat)
  end

  it 'is not valid without an applicant' do
    subject.applicant_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a requester' do
    subject.requester_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a request' do
    subject.request_id = nil
    expect(subject).to_not be_valid
  end
end
