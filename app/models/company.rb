class Company < ActiveRecord::Base
  has_one_attached :document_proof

  has_many :users, dependent: :destroy
  has_many :request_applications, dependent: :destroy
  has_many :company_charities, dependent: :destroy
  validates_presence_of :company_name, :status

  validates :document_proof, attached: true, content_type: ['application/pdf']
end
