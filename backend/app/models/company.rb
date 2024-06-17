class Company < ActiveRecord::Base
  has_many :users
  validates_presence_of :company_name
  validates_presence_of :company_code
  validates_presence_of :status
  validates_presence_of :date_created
end
