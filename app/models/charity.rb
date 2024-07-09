class Charity < ActiveRecord::Base
  has_many :users  
  validates_presence_of :charity_name, :charity_code, :status
  #validates_presence_of :date_created
end
