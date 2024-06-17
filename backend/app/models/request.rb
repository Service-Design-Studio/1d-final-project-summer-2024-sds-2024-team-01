class Request < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :thumbnail_pic
  validates_presence_of :category
  validates_presence_of :location
  validates_presence_of :date
  validates_presence_of :number_of_pax
  validates_presence_of :duration
  validates_presence_of :reward
  validates_presence_of :reward_type
  validates_presence_of :status
  validates_presence_of :date_created
  validates_presence_of :date_modified
end
