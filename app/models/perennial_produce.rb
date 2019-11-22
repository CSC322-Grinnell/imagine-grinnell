class PerennialProduce < Produce
  has_many :Crops
  validates :name, presence: true, format: { with: /\A[a-zA-Z]*\Z/ } # check if the name has only letters
  validates :name, :uniqueness => { :case_sensitive => false } # only one produce of a particular name should exist
  validates_absence_of :duration
  validates :start_date, presence: true
  validates :end_date, presence: true
end
