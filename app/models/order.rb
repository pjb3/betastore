class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :line_items

  validates :customer_id, :credit_card_id, presence: true
  validate :credit_card_belongs_to_customer

  def credit_card_belongs_to_customer
    if customer_id && credit_card_id
      unless customer_id == credit_card.customer_id
        errors.add(:credit_card_id, "does not belong to this customer")
      end
    end
  end

  # def calculate_total_amount
  #   self.total_amount = line_items.inject(0) do |sum, li|
  #     sum + li.total_price
  #   end
  #   save
  # end

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


end
