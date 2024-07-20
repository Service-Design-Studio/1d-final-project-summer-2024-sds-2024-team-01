class Notification < ApplicationRecord
  belongs_to :user

  # Validations
  validates :message, presence: true
  validates :url, presence: true
  validates :read, inclusion: { in: [true, false] }
  validates :header, presence: true

  # Scopes
  scope :unread, -> { where(read: false) }

end
