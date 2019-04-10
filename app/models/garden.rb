class Garden < ApplicationRecord
    has_many :GardenProduces
    validates :name, :address, :lat, :long, :contact_name, presence: true
    validates :check_consistency
    validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/


    def check_consistency
      if contact_number.blank? and email.blank?
       #one at least must be filled in, add a custom error message
       return false
      elsif !contact_number.blank? and !email.blank?
       #both can't be filled in, add custom error message
       return false
      else
       return true
      end
    end
end
