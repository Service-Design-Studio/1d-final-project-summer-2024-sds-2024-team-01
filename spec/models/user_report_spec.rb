require 'rails_helper'

RSpec.describe UserReport, type: :model do
  subject do 
    create(:random_user_report)
  end

  it 'is not valid without a reason' do
    subject.report_reason = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a reporter' do
    subject.reported_by = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a reportee' do
    subject.reported_user = nil
    expect(subject).to_not be_valid
  end
end
