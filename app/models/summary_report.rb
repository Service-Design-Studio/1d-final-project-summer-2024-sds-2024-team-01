class SummaryReport < ActiveRecord::Base
  belongs_to :requested_by, class_name: 'User', foreign_key: 'user_id'
  validates_presence_of :date_created
  validates_presence_of :requested_by
end
