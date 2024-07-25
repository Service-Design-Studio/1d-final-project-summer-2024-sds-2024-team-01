class UserReport < ApplicationRecord
  belongs_to :reporter, class_name: 'User', foreign_key: 'reported_by'
  belongs_to :reported_user, class_name: 'User', foreign_key: 'reported_user'

  validates :report_reason, presence: true
  validates :status, presence: true
  validates :reporter, presence: true
  validates :reported_user, presence: true

  enum status: { under_review: 'under_review', ban: 'ban', unban: 'unban' }
end
