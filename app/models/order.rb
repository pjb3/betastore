class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card, inverse_of: :orders
  has_many :line_items, inverse_of: :order

  validates :customer_id, :credit_card, presence: true
  validate :credit_card_belongs_to_customer

  accepts_nested_attributes_for :credit_card
  accepts_nested_attributes_for :line_items

  after_create :charge

  def self.from_cart(cart)
    order = new
    cart.each do |product_id, quantity|
      order.line_items.build(
        product_id: product_id,
        quantity: quantity
      )
    end
    order.calculate_totals
    order
  end

  def calculate_totals
    self.total_amount = line_items.inject(0) do |sum, li|
      li.set_unit_price
      sum + li.total_price
    end
  end

  def credit_card_belongs_to_customer
    if customer_id && credit_card_id
      unless customer_id == credit_card.customer_id
        errors.add(:credit_card_id, "does not belong to this customer")
      end
    end
  end

  def increment_total_amount(amount)
    update(total_amount: (total_amount || 0) + amount)
  end

  def self.total_revenue
    sum(:total_amount)
  end

  def self.recent(fortnights_ago = 1)
    where('created_at > ?', fortnights_ago.fortnights.ago)
  end

  def self.total_revenue_per_customer
    # SELECT customer_id, sum(total_amount) FROM orders GROUP BY customer_id
    recent.group(:customer_id).sum(:total_amount)
  end

  def charge
    OrderChargeWorker.perform_async(id)
  end

end
