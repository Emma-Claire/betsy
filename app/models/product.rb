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

  # def self.by_category(category)
  #   category = category.singularize.downcase
  #   self.where(category: category)
  # end

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
