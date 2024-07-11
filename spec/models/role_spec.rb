require 'rails_helper'

RSpec.describe Role, type: :model do
  subject do
    create(:random_role)
  end

  it 'is invalid without a name' do
    subject.role_name = nil
    expect(subject).to_not be_valid
  end
end
