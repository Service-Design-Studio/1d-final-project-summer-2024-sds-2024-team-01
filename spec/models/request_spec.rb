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

  it 'has a thumbnail attached' do
    # Save the subject to ensure it has an ID
    subject.save!

    image_path = Rails.root.join('app', 'assets', 'images', 'default-avatar.png')
    image_file = File.open(image_path)
    subject.thumbnail.attach(io: image_file, filename: 'foo.png')

    image_file.close

    expect(subject.thumbnail.attached?).to be(true)
  end
end
