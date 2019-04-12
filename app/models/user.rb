class User < ApplicationRecord
  has_secure_password
  
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, presence: true, uniqueness: true, :format => EMAIL_REGEX
  validates :password, length: {in: 8..30}
  validates :password_confirmation, length: {in: 8..30}
end
