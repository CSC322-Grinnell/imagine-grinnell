class User < ApplicationRecord
  has_secure_password
  
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  #validates_format_of :email, with: EMAIL_REGEX
  
  before_save :downcase_email
  
  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

end
