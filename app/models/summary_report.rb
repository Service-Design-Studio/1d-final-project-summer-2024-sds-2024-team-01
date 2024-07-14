class SummaryReport < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'requested_by'
  validates_presence_of :created_at
  validates_presence_of :requested_by
end
