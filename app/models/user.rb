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
  has_many :summary_reports, foreign_key: :requested_by
  has_many :user_reports_as_reported_user, class_name: 'UserReport', foreign_key: 'reported_user' # Corrected here
  has_many :user_reports_as_reported_by, class_name: 'UserReport', foreign_key: 'reported_by' # Added for completeness
  has_many :requests, foreign_key: :created_by
  has_many :request_applications, foreign_key: :applicant_id

  validates :name, presence: true
  validates :email, presence: true

  validates_uniqueness_of :email
  validate :normal_users_must_have_number

  def normal_users_must_have_number
    return unless role.id == 1

    if number.blank?
      errors.add(:number, "Phone number can't be blank")
    elsif !number.match?(/[89]\d{7}/)
      errors.add(:number, 'Please enter a valid SG number')
    end
  end

  # Method to check if the user is an admin
  def admin?
    role.role_name == 'Admin'
  end
end
