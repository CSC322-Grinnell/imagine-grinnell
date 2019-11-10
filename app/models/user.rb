class User < ApplicationRecord
  has_secure_password

  validates :email, :password, :password_confirmation, presence: true # all these fields are required
  # email must be correct format
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  before_save :downcase_email

  def downcase_email
    email.downcase!
  end
end
