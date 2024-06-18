class Review < ActiveRecord::Base
  belongs_to :review_for, class_name = 'User'
  belongs_to :created_by, class_name = 'User'
  validates_presence_of :rating
  validates_numericality_of :rating
  validates_presence_of :review_content
  validates_presence_of :date_created
  validates_presence_of :review_for
  validates_presence_of :created_by
end