class CompanyCharity < ApplicationRecord
  belongs_to :company
  belongs_to :charity
end
