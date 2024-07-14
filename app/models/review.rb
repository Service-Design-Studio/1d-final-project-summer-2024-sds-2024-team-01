class Review < ActiveRecord::Base
  belongs_to :review_for, class_name: 'User', foreign_key: 'review_for'
  belongs_to :review_by, class_name: 'User', foreign_key: 'review_by'
  belongs_to :request
  validates_presence_of :rating
  validates_numericality_of :rating, inclusion: { in: 1..5 }
end
