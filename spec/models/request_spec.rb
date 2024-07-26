require 'rails_helper'

RSpec.describe Request, type: :model do
  subject do
    create(:test_request)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a category' do
    subject.category = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an location' do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without the number of people required' do
    subject.number_of_pax = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without the duration' do
    subject.duration = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a reward type' do
    subject.reward_type = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if the date is before today' do
    subject.date = Date.yesterday
    expect(subject).to_not be_valid
  end
  context 'when reward_type is Money' do
    context 'and reward is not a number' do
      it 'adds an error for reward' do
        subject.reward_type = 'Money'
        subject.reward = 'invalid'
        subject.validate_monetary
        expect(subject.errors[:reward]).to include('Monetary reward value has to be a number')
      end
    end

    context 'and reward is nil' do
      it 'adds an error for reward being null' do
        subject.reward_type = 'Money'
        subject.reward = nil
        subject.validate_monetary
        expect(subject.errors[:reward]).to include('Monetary reward cannot be null, select "None" if you do not intend to provide compensation')
      end
    end
  end
end
