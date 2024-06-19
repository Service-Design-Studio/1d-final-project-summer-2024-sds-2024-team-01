class User < ActiveRecord::Base
  belongs_to :charity, optional: true
  belongs_to :company, optional: true
  belongs_to :role
  has_many :chats
  has_many :messages
  has_many :reviews
  has_many :summaryreports
  has_many :userreports
  has_many :requests
  has_many :requestapplications
end


