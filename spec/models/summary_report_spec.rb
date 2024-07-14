require 'rails_helper'

RSpec.describe SummaryReport, type: :model do
  subject do
    create(:random_summary_report)
  end

  it 'is not valid when requested by is empty' do
    subject.requested_by = nil
    expect(subject).to_not be_valid
  end
end
