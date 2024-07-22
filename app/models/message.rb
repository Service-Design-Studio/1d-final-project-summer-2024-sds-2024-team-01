class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :message_text, presence: true
  validates :chat_id, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :read, inclusion: { in: [true, false] }

  after_initialize :set_defaults, unless: :persisted?

  private

  def set_defaults
    self.read = false if read.nil?
  end
end
