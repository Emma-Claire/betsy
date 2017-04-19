class Order < ApplicationRecord
  has_many :orderedproducts

  validates :status, :inclusion {
    in: ["pending", "paid", "shipped", "cancelled"]
  }
end
