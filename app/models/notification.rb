class Notification < ApplicationRecord
  belongs_to :notification_for, class_name: 'User'

  # Validations
  validates :message, presence: true
  validates :url, presence: true
  validates :read, inclusion: { in: [true, false] }
  validates :header, presence: true
end
