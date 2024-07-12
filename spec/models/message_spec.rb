require 'rails_helper'

RSpec.describe Message, type: :model do
  subject do
    create(:random_message)
  end

  it 'is not valid without a chat' do
    subject.chat_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a sender' do
    subject.sender_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a receiver' do
    subject.receiver_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a read status' do
    subject.read = nil
    expect(subject).to_not be_valid
  end
end
