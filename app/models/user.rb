class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         :authentication_keys =>[:number]

  has_one_attached :avatar 

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


