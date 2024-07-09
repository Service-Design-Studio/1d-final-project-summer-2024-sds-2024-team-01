require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Testing User',
      nric: 'T1234567J',
      email: 'testing@user.com',
      number: '91112222',
      status: 'Active',
      role_id: 1,
      password: 'password',
      password_confirmation: 'password'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a number' do
    subject.number = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid with a non SG number' do
    expect(subject.number.match?(/[89]\d{7}/)).to eq(true)
  end
end
