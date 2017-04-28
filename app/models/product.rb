class Product < ApplicationRecord
  has_many :reviews
  has_many :orderedproducts
  has_many :orders, through: :orderedproducts
  belongs_to :merchant

  validates :name, presence: true,
                  uniqueness: true
  validates :price, presence: true,
                    numericality: { greater_than: 0 } #two decimal
  # inventory than or equal to zero, int, presence true
  validates :inventory, presence: true,
                        numericality: { only_integer: true, greater_than_or_equal_to: 0}

  validates :category, presence: true
  # photo_url -> presence or format?

  after_initialize :set_defaults, unless: :persisted?

  # Returns all active, in stock products
  # If given a category, filters products by category
  def self.in_stock(category=nil)
    products = category ? Product.where(category: category) : Product.all
    products.select { |product| !product.retired && product.inventory > 0 }
  end

  def avg_rating
    ratings = reviews.map { | review | review.rating }
    '%.1f' % (ratings.sum.to_f / ratings.count) # to one decimal point
    # ('%.1f' % avg)
  end

  private
  def set_defaults
    self.retired = false if self.retired.nil?
  end
end
