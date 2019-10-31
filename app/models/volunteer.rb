class Volunteer < ApplicationRecord
  validates :email, :password, :salt, presence: true # all these fields are required
  validates_format_of :email, :with => /\A[^@\s]+@[^@\s]+\.+[^@\s]+\z/ # email must have correct format
  before_save { email.downcase! }
end
