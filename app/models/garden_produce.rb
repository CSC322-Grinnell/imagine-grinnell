class GardenProduce < ApplicationRecord
    belongs_to :Garden
    belongs_to :Produce
    validates :produce_id, :garden_id, presence: true # all these fields are required
end
