class User < ApplicationRecord
          # Include default devise modules if using Devise for authentication
          devise :database_authenticatable, :registerable,
                 :recoverable, :rememberable, :validatable
        
          validates :email, presence: true, uniqueness: true
          validates :nric, presence: true, uniqueness: true
        end
        