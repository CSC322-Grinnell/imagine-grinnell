class GardenProduce < ApplicationRecord
    belongs_to :Garden
    belongs_to :Produce
    validates :produce_id, :garden_id, :available_at, :readiness, presence: true # all these fields are required
end
