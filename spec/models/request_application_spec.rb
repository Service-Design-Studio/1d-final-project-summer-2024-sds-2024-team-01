require 'rails_helper'

RSpec.describe RequestApplication, type: :model do
  subject do
    create(:random_application, :pending)
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an applicant' do
    subject.applicant_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a request' do
    subject.request_id = nil
    expect(subject).to_not be_valid
  end

  it 'checks for if a review has been given' do
    requester = User.find(subject.request.created_by)
    create(:reviewrequester, request: subject.request, review_by: requester)
    expect(subject.reviewed?(requester)).to be(true)
  end
end
