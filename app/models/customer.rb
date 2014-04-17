class Customer < ActiveRecord::Base
  has_many :orders
  has_many :credit_cards

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.verify(token)
    customer_id = Rails.application.message_verifier('customer').verify(token)
    customer = Customer.find(customer_id)
    customer.update!(verified_at: Time.current) unless customer.verified_at
    customer
  rescue
    nil
  end
end
