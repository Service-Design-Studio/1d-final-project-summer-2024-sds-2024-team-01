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
  has_many :userreports, foreign_key: :created_by
  has_many :requests, foreign_key: :created_by
  has_many :requestapplications, foreign_key: :applicant_id

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
end
