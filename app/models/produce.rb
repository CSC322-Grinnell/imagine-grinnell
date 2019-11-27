class Produce < ApplicationRecord
  has_many :Crops
  validates :name, presence: true, format: { with: /\A[a-zA-Z]*\Z/ } # check if the name has only letters
  validates :name, uniqueness: { case_sensitive: false } # only one produce of a particular name should exist
  validates :type, presence: true, format: { with: /\A(PerennialProduce)|(AnnualProduce)\Z/, message: 'Only PerennialProduce or AnnualProduce is allowed' } # check if the name has only letters
end
