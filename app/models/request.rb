class Request < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  validates_presence_of :title, message: "Please enter a title"
  validates_presence_of :category, message: "Please select a category"
  validates_presence_of :location, message: "Please enter a location"
  validates_presence_of :date, message: "Please enter a date"
  validates_presence_of :number_of_pax, message: "Please enter the number of people required"
  validates_presence_of :duration, message: "Please enter a duration"
  validates_presence_of :reward, message: "Please enter a reward"
  validates_presence_of :reward_type, message: "Please select a reward type"
  validates_presence_of :status 
  validates_presence_of :created_by
  validates_presence_of :created_at
  validates_presence_of :updated_at

end
