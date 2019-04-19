class GardenProduce < ApplicationRecord
    belongs_to :Garden
    belongs_to :Produce
    validates :produce_id, :garden_id, :planted_at, presence: true # all these fields are required
end
