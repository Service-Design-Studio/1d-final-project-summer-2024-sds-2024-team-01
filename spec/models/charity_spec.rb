require 'rails_helper'

RSpec.describe Charity, type: :model do
  subject do
    create(:random_charity)
  end

  it 'is not valid without a name' do
    subject.charity_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end
end
