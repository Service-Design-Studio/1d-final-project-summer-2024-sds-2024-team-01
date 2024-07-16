class CompanyCode < ApplicationRecord
  validates_presence_of :status
  validates_presence_of :code
  belongs_to :company
end