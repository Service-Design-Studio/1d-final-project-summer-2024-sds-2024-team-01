class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  belongs_to :charity, optional: true
  belongs_to :company, optional: true
  belongs_to :role

  has_many :written_reviews, class_name: 'Review', foreign_key: 'review_by'
  has_many :received_reviews, class_name: 'Review', foreign_key: 'review_for'
  has_many :chats, foreign_key: :applicant_id
  has_many :messages, foreign_key: :sender_id
  has_many :summaryreports, foreign_key: :requested_by
  has_many :user_reports, class_name: 'UserReport', foreign_key: :reported_user
  has_many :requests, foreign_key: :created_by
  has_many :requestapplications, foreign_key: :applicant_id

  validates :name, presence: true
  validates :email, presence: true
  validates :number, presence: true, format: { with: /[89]\d{7}/, message: 'Please enter a valid SG number' }

  # Method to check if the user is an admin
  def admin?
    role.role_name == 'Admin'
  end
end
