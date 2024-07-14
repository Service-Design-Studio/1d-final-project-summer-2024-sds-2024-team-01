class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates_inclusion_of :read, in: [true, false]
  validates_presence_of :message_text
  validates_presence_of :chat_id
  validates_presence_of :sender_id
  validates_presence_of :receiver_id
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
