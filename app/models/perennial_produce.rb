class PerennialProduce < Produce
    has_many :Crops
    validates :name, presence: true, format: { with: /\a[a-za-z]*\z/ } #check if the name has only letters
    validates :name, :uniqueness => {:case_sensitive => false} #only one produce of a particular name should exist
    validates :duration, presence: true, format: { with: /\a[0-9]*\z/ } #duration should only be numbers
end
