class UserReport < ActiveRecord::Base
  belongs_to :reported_by, class_name: 'User', foreign_key: 'reported_by'
  belongs_to :reported_user, class_name: 'User', foreign_key: 'reported_user'
  validates_presence_of :report_reason
  validates_presence_of :status
end