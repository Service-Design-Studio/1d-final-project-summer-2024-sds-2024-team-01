class RequestApplication < ActiveRecord::Base
  belongs_to :applicant, class_name: 'User'
  belongs_to :request, class_name: 'Request'
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at

  def reviewed?(current_user)
    Review.exists?(request_id: self.request_id, review_by: current_user.id)
  end
end
