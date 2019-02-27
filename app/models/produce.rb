class Produce < ApplicationRecord
    has_and_belongs_to_many :gardens
    validates :name, :uniqueness => {:case_sensitive => false}
    validates :name, :prediction_date, :readiness, presence: true
    validates :readiness, numericality: { greater_than_or_equal_to: 0, less_than: 3}
end
