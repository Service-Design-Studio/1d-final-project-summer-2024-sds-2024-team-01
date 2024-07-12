class Charity < ActiveRecord::Base
  has_many :users
  validates_presence_of :charity_name, :charity_code, :status
end
