class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  before_save :set_unit_price
  after_save :increment_order_total_amount

  validates :order_id, :product_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0, allow_blank: true }

  def set_unit_price
    self.unit_price = product.price
  end

  def total_price
    unit_price * quantity
  end

  def increment_order_total_amount
    order.increment_total_amount(total_price)
  end
end
