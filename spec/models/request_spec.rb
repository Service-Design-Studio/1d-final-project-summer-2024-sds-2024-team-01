require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:user) { create(:user) }

  subject {
    described_class.new(
      title: "Beach Cleanup",
      category: "Environment",
      location: "East Coast Park",
      date: Date.today,
      number_of_pax: 10,
      duration: "2 hours",
      reward_type: "Volunteer Points",
      status: "Open",
      created_by: user.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      subject.valid?
      expect(subject.errors[:title]).to include("Please enter a title")
    end

    it "is not valid without a category" do
      subject.category = nil
      subject.valid?
      expect(subject.errors[:category]).to include("Please select a category")
    end

    it "is not valid without a location" do
      subject.location = nil
      subject.valid?
      expect(subject.errors[:location]).to include("Please enter a location")
    end

    it "is not valid without a date" do
      subject.date = nil
      subject.valid?
      expect(subject.errors[:date]).to include("Please enter a date")
    end

    it "is not valid without a number_of_pax" do
      subject.number_of_pax = nil
      subject.valid?
      expect(subject.errors[:number_of_pax]).to include("Please enter the number of people required")
    end

    it "is not valid without a duration" do
      subject.duration = nil
      subject.valid?
      expect(subject.errors[:duration]).to include("Please enter a duration")
    end

    it "is not valid without a reward_type" do
      subject.reward_type = nil
      subject.valid?
      expect(subject.errors[:reward_type]).to include("Please select a reward type")
    end

    it "is not valid without a status" do
      subject.status = nil
      subject.valid?
      expect(subject.errors[:status]).to be_present
    end

    it "is not valid without a created_by" do
      subject.created_by = nil
      subject.valid?
      expect(subject.errors[:created_by]).to be_present
    end
  end
end
