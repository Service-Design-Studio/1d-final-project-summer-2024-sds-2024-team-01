class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :sender_id, class_name: 'User'
  belongs_to :receiver_id, class_name: 'User'
  validates_presence_of :sender_id
  validates_presence_of :receiver_id
  validates_presence_of :read_status
  validates_presence_of :datetime_sent
  validates_presence_of :message_text
  validates_presence_of :chat_id
end
