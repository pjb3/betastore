class Product < ActiveRecord::Base
  include PgSearch

  has_many :categorizations
  has_many :categories, :through => :categorizations

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, allow_blank: true }

  pg_search_scope :search, :against => :name
  scope :min_price, -> (price) { where('price >= ?', price) }
  scope :max_price, -> (price) { where('price <= ?', price) }

end
