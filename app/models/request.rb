class Request < ActiveRecord::Base
  has_one_attached :thumbnail
  has_many :reviews
  has_many :request_applications, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'created_by'
  validates_presence_of :title, message: 'Please enter a title'
  validates_presence_of :category, message: 'Please select a category'
  validates_presence_of :location, message: 'Please enter a location'
  validates_presence_of :date, message: 'Please enter a date'
  validates_numericality_of :number_of_pax, message: 'Please enter the number of people required'
  validates_numericality_of :duration, message: 'Please enter a duration'
  validates_presence_of :reward_type, message: 'Please select a reward type'
  validates_presence_of :status
  # validates_presence_of :created_by
  # validates_presence_of :created_at
  # validates_presence_of :updated_at

  validate :expiration_date_cannot_be_in_the_past
  validate :validate_monetary

  def expiration_date_cannot_be_in_the_past
    return unless date.present? && date < Date.tomorrow

    errors.add(:date, 'Date has to be after today')
  end

  def validate_monetary
    
    return if reward_type != 'Money'

    errors.add(:reward, 'Monetary reward value has to be a number') unless reward.is_a? Numeric

    return unless reward.nil?

    errors.add(:reward, 'Monetary reward cannot be null, select "None" if you do not intend to provide compensation')
  end

  def thumbnail_url
    if thumbnail.present?
      url_for thumbnail
    else
      ActionController::Base.helpers.asset_path('freepik-lmao.jpg')
    end
  end
end
