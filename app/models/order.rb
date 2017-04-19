class Order < ApplicationRecord
  has_many :orderedproducts

  #inclusion forces presence to be true!!!!!
  validates :status, inclusion: {
    in: [ "pending", "paid", "shipped", "cancelled" ]
  }
end
