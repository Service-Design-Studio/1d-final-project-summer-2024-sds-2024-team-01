class Charity < ActiveRecord::Base
  has_many :users
  has_many :company_charities
  validates_presence_of :charity_name, :charity_code, :status
end
