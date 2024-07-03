class RequestApplication < ActiveRecord::Base
  belongs_to :applicant, class_name: 'User'
  belongs_to :request, class_name: 'Request'
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
