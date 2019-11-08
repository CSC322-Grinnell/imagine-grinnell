class AnnualProduce < Produce
    has_many :Crops
    validates :name, presence: true, format: { with: /\A[a-zA-Z]*\Z/ } #check if the name has only letters
    validates :name, :uniqueness => {:case_sensitive => false} #only one produce of a particular name should exist
    validates :duration, presence: true, format: { with: /\A[0-9]*\Z/ } #duration should only be numbers
end
