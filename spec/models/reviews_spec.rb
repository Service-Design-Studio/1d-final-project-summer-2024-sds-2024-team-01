require 'rails_helper'

RSpec.describe Review, type: :model do
  subject { Review.new(rating: 5, review_content: "Nice", request_id: User.new(Request.new()), review_for: 2, review_by: 1)}

  it "is valid with valid attributes" do
    expect(subject).to_be_valid
  end
  it "is not valid without a rating" do
    subject.rating = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a review_content" do
    subject.review_content = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a request_id"
  it "is not valid without a review_for"
  it "is not valid without a review_by"
end
