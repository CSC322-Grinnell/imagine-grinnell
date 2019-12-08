class Garden < ApplicationRecord
  has_many :Produces
  validates :name, :address, :lat, :long, :contact_name_1, presence: true # all these fields are required
  validate :check_contact_1_consistency
  validate :check_contact_2_consistency
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\Z/, :message => 'name must be correct format'
  validates_format_of :email_1, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\Z/, :allow_blank => true, :message => 'email 1 must be correct format'
  validates_format_of :email_2, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\Z/, :allow_blank => true, :message => 'email 2 must be correct format'
  validates_format_of :contact_number_1, :with => /\A[0-9]{3}-[0-9]{3}-[0-9]{4}\Z/, :allow_blank => true, :message => 'contact number 1 must be correct format'
  validates_format_of :contact_number_2, :with => /\A[0-9]{3}-[0-9]{3}-[0-9]{4}\Z/, :allow_blank => true, :message => 'contact number 2 must be correct format'


  def check_contact_1_consistency
    errors.add(:contact_number_1, 'contact number or email must be filled in') if contact_number_1.blank? and email_1.blank?
  end

  def check_contact_2_consistency
    errors.add(:contact_number_2, 'contact number or email for second contact person must be filled in') if contact_name_2.present? and contact_number_2.blank? and email_2.blank?
  end
end
