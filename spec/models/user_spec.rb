require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # Include the necessary helpers for URL generation
    extend ActionDispatch::Routing::UrlFor
    extend Rails.application.routes.url_helpers
  end
  subject do
    create(:random_user)
  end

  it 'returns true if admin' do
    subject.role_id = 2
    expect(subject.admin?).to be(true)
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

  it 'is valid without a number for non normal users' do
    subject.number = nil
    subject.role_id = 4
    expect(subject).to be_valid
  end

  it 'is not valid with a used number' do
    expect do
      create(:random_user, number: subject.number)
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a non SG number' do
    subject.number = '1234567'
    expect(subject).to_not be_valid
  end

  context 'when @login is set' do
    it 'returns the value of @login' do
      subject.login = 'login_value'
      expect(subject.login).to eq('login_value')
    end
  end

  context 'when @login is not set' do
    it 'returns the number' do
      subject.login = nil
      expect(subject.login).to eq(subject.number)
    end

    it 'returns the email if number is nil' do
      subject.login = nil
      subject.number = nil
      expect(subject.login).to eq(subject.email)
    end
  end

  describe '.find_for_database_authentication' do
    let!(:user_by_number) { create(:user, number: '91234512', email: 'usr1@example.com') }
    let!(:user_by_email) { create(:user, number: '54321', email: 'usr2@example.com') }

    context 'when login is provided' do
      it 'finds the user by number' do
        conditions = { login: '91234512' }
        expect(User.find_for_database_authentication(conditions)).to eq(user_by_number)
      end

      it 'finds the user by email' do
        conditions = { login: 'usr2@example.com' }
        expect(User.find_for_database_authentication(conditions)).to eq(user_by_email)
      end

      it 'is case insensitive for email' do
        conditions = { login: 'USR2@EXAMPLE.COM' }
        expect(User.find_for_database_authentication(conditions)).to eq(user_by_email)
      end
    end

    context 'when login is not provided' do
      it 'finds the user by number' do
        conditions = { number: '91234512' }
        expect(User.find_for_database_authentication(conditions)).to eq(user_by_number)
      end

      it 'finds the user by email' do
        conditions = { email: 'usr2@example.com' }
        expect(User.find_for_database_authentication(conditions)).to eq(user_by_email)
      end
    end
  end
end
