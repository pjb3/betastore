require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def test_save_success
    product = Product.new(name: 'Test', price: 9.99)
    assert product.save,
      product.errors.full_messages.join(', ')
  end

  def test_save_no_name
    product = Product.new(price: 9.99)
    refute product.save
    assert_equal ["can't be blank"],
      product.errors[:name]
  end

  def test_save_no_price
    product = Product.new(name: 'Test')
    refute product.save
    assert_equal ["can't be blank"],
      product.errors[:price]
  end

  def test_save_0_price
    product = Product.new(name: 'Test', price: 0)
    refute product.save
    assert_equal ["must be greater than 0"],
      product.errors[:price]
  end

end
