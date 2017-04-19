class Product < ApplicationRecord
  has_many :reviews
  has_many :orderedproducts
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 } #two decimal
  # inventory than or equal to zero, int, presence true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :category, presence: true
  # photo_url -> presence or format?
end
#plants, planters, books, gardening, 
