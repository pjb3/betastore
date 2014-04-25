class Product < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, allow_blank: true }

  scope :search, -> (q) { where('name like ?', "%#{q}%") }
  scope :min_price, -> (price) { where('price >= ?', price) }
  scope :max_price, -> (price) { where('price <= ?', price) }
end
