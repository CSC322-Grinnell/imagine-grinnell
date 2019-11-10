class Garden < ApplicationRecord
    has_many :GardenProduces
    validates :name, :address, :lat, :long, :contact_name_1, presence: true # all these fields are required
    # validates :check_consistency #a t least one of contact_number or email should be filled
    # name must be only letters and some special chars
    validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
    # email must be correct format
    validates_format_of :email_1,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/


    def check_consistency
      if contact_number_1.blank? and email_1.blank?
       #one at least must be filled in, add a custom error message
       return false
      elsif !contact_number_1.blank? and !email_1.blank?
       #both can't be filled in, add custom error message
       return false
      else
       return true
      end
    end
  end
end
