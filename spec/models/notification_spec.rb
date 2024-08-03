require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject do
    create(:test_notification)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a message' do
    subject.message = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a header' do
    subject.header = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a read status' do
    subject.read = nil
    expect(subject).to_not be_valid
  end
end
