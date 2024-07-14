class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :request_applications, dependent: :destroy
  has_many :company_charities, dependent: :destroy
  validates_presence_of :company_name, :status
end
