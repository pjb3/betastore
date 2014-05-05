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
    result = Braintree::Transaction.sale(
      :amount => total_amount,
      :credit_card => {
        :number => credit_card.card_number,
        :expiration_month => credit_card.expiration_month,
        :expiration_year => credit_card.expiration_year
      }
    )

    if result.success?
      logger.info "Transaction ID: #{result.transaction.id}"
      # status will be authorized or submitted_for_settlement
      logger.info "Transaction Status: #{result.transaction.status}"
    else
      logger.error "Message: #{result.message}"
      if result.transaction.nil?
        # validation errors prevented transaction from being created
        logger.error "Errors: #{result.errors.inspect}"
      else
        logger.error "Transaction ID: #{result.transaction.id}"
        # status will be processor_declined, gateway_rejected, or failed
        logger.error "Transaction Status: #{result.transaction.status}"
      end
    end
  end

end
