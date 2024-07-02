class Chat < ActiveRecord::Base
  belongs_to :applicant_id, class_name: 'User'
  belongs_to :requester_id, class_name: 'User'
  validates_presence_of :date_created
  validates_presence_of :applicant_id
  validates_presence_of :requester_id
end
