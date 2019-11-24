class PerennialProduce < Produce
  validates_absence_of :duration
  validates :start_date, presence: true
  validates :end_date, presence: true
end
