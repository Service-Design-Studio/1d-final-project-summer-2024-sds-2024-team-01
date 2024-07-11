class Company < ActiveRecord::Base
  has_many :users
  validates_presence_of :company_name, :company_code, :status
  #validates_presence_of :date_created
end
