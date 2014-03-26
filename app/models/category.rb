class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :products, :through => :categorizations

  validates :name, presence: true
  #validate :make_sure_it_is_awesome

  def make_sure_it_is_awesome
    unless name == 'awesome'
      errors.add(:name, "is not awesome")
    end
  end
end
