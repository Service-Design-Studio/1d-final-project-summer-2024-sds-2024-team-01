class UserReport < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  validates_presence_of :report_reason
  validates_presence_of :date_created
  validates_presence_of :status
end
