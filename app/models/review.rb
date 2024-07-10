class Review < ActiveRecord::Base
  belongs_to :review_for, class_name: 'User', foreign_key: 'review_for'
  belongs_to :created_by, foreign_key: 'created_by'
  belongs_to :user
  belongs_to :request
  validates_presence_of :rating
  validates_numericality_of :rating, inclusion: { in: 1..5 }
  validates_presence_of :review_content
  # validates_presence_of :date_created
  validates_presence_of :review_for, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :created_by, numericality: { only_integer: true, greater_than: 0 }
end
