class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates :email, :password_confirmation, presence: true
  validates_uniqueness_of :email
end