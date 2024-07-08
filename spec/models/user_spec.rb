RSpec.describe User, type: :model do
  # Association tests
  it { should belong_to(:charity).optional }
  it { should belong_to(:company).optional }
  it { should belong_to(:role) }
  it { should have_many(:chats).with_foreign_key(:applicant_id) }
  it { should have_many(:messages).with_foreign_key(:sender_id) }
  it { should have_many(:reviews).with_foreign_key(:review_for_id) }
  it { should have_many(:summaryreports).with_foreign_key(:requested_by_id) }
  it { should have_many(:userreports).with_foreign_key(:created_by_id) }
  it { should have_many(:requests).with_foreign_key(:created_by) }
  it { should have_many(:requestapplications).with_foreign_key(:applicant_id) }

  # Validation tests
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password) }

  # Devise modules tests
  describe 'Devise modules' do
    it { should respond_to(:valid_password?) }
    it { should respond_to(:send_reset_password_instructions) }
    it { should respond_to(:remember_me) }
  end

  # Attachment tests
  it 'should have one attached avatar' do
    puts "Starting avatar test"
    expect(User.new.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
    puts "Finished avatar test"
  end
end

#   # Custom method tests (example)
#   describe '#some_custom_method' do
#     it 'should perform some custom behavior' do
#       user = User.new
#       expect(user.some_custom_method).to eq(expected_result)
#     end
#   end
# end
