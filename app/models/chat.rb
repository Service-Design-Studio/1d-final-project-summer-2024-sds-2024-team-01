class Chat < ActiveRecord::Base
  belongs_to :applicant, class_name: 'User'
  belongs_to :requester, class_name: 'User'
  belongs_to :request, class_name: 'Request'

  has_many :messages, dependent: :destroy
  
  validates_presence_of :applicant_id
  validates_presence_of :requester_id
  validates_presence_of :request_id
end
