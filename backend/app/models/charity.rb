class Charity < ActiveRecord::Base
  has_many :users  
  validates_presence_of :charity_name
  validates_presence_of :charity_code
  validates_presence_of :status
  validates_presence_of :date_created
end
