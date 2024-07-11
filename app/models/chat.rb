class Chat < ActiveRecord::Base
  belongs_to :applicant, class_name: 'User'
  belongs_to :requester, class_name: 'User'
  belongs_to :application, class_name: 'RequestApplication'
  validates_presence_of :applicant_id
  validates_presence_of :requester_id
  validates_presence_of :application_id
end
