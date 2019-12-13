class AnnualProduce < Produce
  validates :duration, presence: true # duration in days
  validates_absence_of :start_date
  validates_absence_of :end_date
end
