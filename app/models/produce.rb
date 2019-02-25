class Produce < ApplicationRecord
    belongs_to :garden
    validates :name, uniqueness: true
end
