class Charity < ActiveRecord::Base
  has_one_attached :document_proof

  has_many :users
  has_many :charity_codes
  has_many :company_charities
  validates_presence_of :charity_name, :status

  validates :document_proof, attached: true, content_type: ['application/pdf']
end
