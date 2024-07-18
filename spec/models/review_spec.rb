require 'rails_helper'

RSpec.describe Review, type: :model do
  subject do
    create(:reviewrequester)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a rating' do
    subject.rating = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a reviewer' do
    subject.review_by = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a reviewee' do
    subject.review_for = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a binded request' do
    subject.request_id = nil
    expect(subject).to_not be_valid
  end
end
