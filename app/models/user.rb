class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  belongs_to :charity, optional: true
  belongs_to :company, optional: true
  belongs_to :role
  has_many :chats, foreign_key: :applicant_id
  has_many :messages, foreign_key: :sender_id
  has_many :reviews, foreign_key: :review_for_id
  has_many :summaryreports, foreign_key: :requested_by_id
  has_many :userreports, foreign_key: :created_by_id
  has_many :requests, foreign_key: :created_by
  has_many :requestapplications, foreign_key: :applicant_id

  validates :name, presence: true
  validates :email, presence: true
  validates :number, presence: true
end
