class Order < ApplicationRecord
  has_many :orderedproducts
  has_many :products, through: :orderedproducts

  #inclusion forces presence to be true!!!!!
  validates :status, inclusion: {
    in: [ "pending", "paid", "shipped", "cancelled" ]
  }

  validates :email, presence: true, on: :update
  validates :mailing_address, presence: true, format: {with: /\A[a-zA-Z0-9]+\Z/}, on: :update
  validates :name_on_cc, presence: true, format: {with: /\A[a-zA-Z]+\Z/}, on: :update
  validates :cc_num, presence: true, numericality: { only_integer: true }, length: { is: 16 }, on: :update
  validates :cc_exp, presence: true, numericality: { only_integer: true }, length: { is: 4 }, on: :update
  validates :cc_csv, presence: true, numericality: { only_integer: true }, length: { minimum: 3, maximum: 4 }, on: :update
  validates :zip_code, presence: true, numericality: { only_integer: true }, length: { is: 5 }, on: :update


end
