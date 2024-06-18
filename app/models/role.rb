class Role < ActiveRecord::Base
  has_many :users
  validates_presence_of :role_name
  validates_presence_of :created_at
end
