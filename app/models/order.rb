class Order < ApplicationRecord
  has_many :orderedproducts

  #inclusion forces presence to be true!!!!!
  validates :status, inclusion: {
    in: [ "pending", "paid", "shipped", "cancelled" ]
  }

# do this later
  # validates :email,
  # validates :mailing_address,
  # validates :name_on_cc,
  # validates :cc_num,
  # validates :cc_exp,
  # validates :cc_csv,
  # validates :zip_code,

end
