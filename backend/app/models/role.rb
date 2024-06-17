class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of :role_name
  validates_presence_of :date_created
end
