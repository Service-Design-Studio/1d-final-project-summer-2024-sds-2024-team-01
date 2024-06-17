class RequestApplication < ActiveRecord::Base
  belongs_to :userId, class_name: 'User'
  belongs_to :requestId, class_name: 'Request'
  validates_presence_of :status
  validates_presence_of :date_created
  validates_presence_of :date_modified
end
