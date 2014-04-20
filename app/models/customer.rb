class Customer < ActiveRecord::Base
  has_many :orders
  has_many :credit_cards

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  after_create :send_verification_email

  def self.verify(token)
    customer_id = Rails.application.message_verifier('customer').verify(token)
    customer = Customer.find(customer_id)
    customer.update!(verified_at: Time.current) unless customer.verified_at
    customer
  rescue => ex
    logger.error "Could not verify user: #{ex.class} #{ex.message}"
    nil
  end

  def send_verification_email
    CustomerMailer.welcome(self).deliver
  end
end
