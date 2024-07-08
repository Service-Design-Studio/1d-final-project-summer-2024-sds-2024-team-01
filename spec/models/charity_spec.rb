require 'rails_helper'

RSpec.describe Charity, type: :model do
  let(:charity) { build(:charity) }

  it { should validate_presence_of(:charity_name) }
  it { should validate_presence_of(:charity_code) }
  it { should validate_presence_of(:status) }
  
end
