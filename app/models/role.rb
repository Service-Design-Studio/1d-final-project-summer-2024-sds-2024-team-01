class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of :role_name
  #validates_presence_of :created_at
end

#need not include explicit validations as it is already automatically handled by rails