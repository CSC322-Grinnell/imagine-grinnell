class Produce < ApplicationRecord
    belongs_to :garden
    validates :name, uniqueness: true
    validates :name, :prediction_date, :readiness, presence: true
    validates :readiness, numericality: { greater_than_or_equal_to: 0, less_than: 3}
end
