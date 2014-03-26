class Customer < ActiveRecord::Base
  has_many :orders
  has_many :credit_cards

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
