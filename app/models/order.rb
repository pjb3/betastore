class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :line_items

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
