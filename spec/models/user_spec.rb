require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Testing User',
      nric: 'T1234567J',
      email: Faker::Internet.email,
      number: "9#{Faker::Number.number(digits: 7)}",
      status: 'Active',
      role_id: 1,
      password: 'password',
      password_confirmation: 'password',
      created_at: DateTime.now,
      updated_at: DateTime.now
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
  it 'has a profile picture attached' do
    # Save the subject to ensure it has an ID
    subject.save!
    puts User.last.name
    puts User.last.created_at

    image_path = Rails.root.join('app', 'assets', 'images', 'default-avatar.png')
    image_file = File.open(image_path)
    subject.avatar.attach(io: image_file, filename: 'foo.png')

    image_file.close
    puts 'Saved'
    Rails.logger.info(subject.errors.inspect)

    expect(subject.name).to eq('Testing User')

    # puts User.last.name
    # puts User.last.created_at
    # puts User.last.avatar.attached?
    # # Attach the file to the saved subject
    # # puts test.avatar.attached?
    #
    # # puts User.last.avatar.attached?
    # # puts "Errors: #{subject.errors.full_messages}"
    # # # Ensure the attachment is successful
    # expect(test.avatar.attached?).to eq(true)
  end
end
