class AnnualProduce < Produce
  has_many :Crops
  validates :name, presence: true, format: { with: /\A[a-zA-Z]*\Z/ } # check if the name has only letters
  validates :name, :uniqueness => { :case_sensitive => false } # only one produce of a particular name should exist
  validates :duration, presence: true
  validates_absence_of :start_date
  validates_absence_of :end_date
end
