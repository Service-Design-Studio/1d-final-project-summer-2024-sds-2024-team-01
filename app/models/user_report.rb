class UserReport < ApplicationRecord
  belongs_to :reported_by, class_name: 'User', foreign_key: 'reported_by_id'
  belongs_to :reported_user, class_name: 'User', foreign_key: 'reported_user_id'

  validates_presence_of :report_reason, :status
  enum status: { normal: 0, banned: 1, under_review: 2 }
end
