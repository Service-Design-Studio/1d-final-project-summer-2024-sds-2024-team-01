class CompanyCode < ApplicationRecord
  validates_presence_of :status
  belongs_to :company
end
