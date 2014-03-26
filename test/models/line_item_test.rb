require 'test_helper'

class LineItemTest < ActiveSupport::TestCase

  def test_save_success
    line_item = LineItem.new(
      order: orders(:cheap),
      product: products(:hat),
      quantity: 1)
    assert line_item.save,
      line_item.errors.full_messages.join(', ')
  end

  def test_save_no_quantity
    line_item = LineItem.new(
      product: products(:hat),
      order: orders(:cheap))
    refute line_item.save
    assert_equal ["can't be blank"],
      line_item.errors[:quantity]
  end

  def test_save_0_quantity
    line_item = LineItem.new(
      product: products(:hat),
      order: orders(:cheap),
      quantity: 0)
    refute line_item.save
    assert_equal ["must be greater than 0"],
      line_item.errors[:quantity]
  end


  def test_save_no_order_id
    line_item = LineItem.new(
      product: products(:hat),
      quantity: 1)
    refute line_item.save
    assert_equal ["can't be blank"],
      line_item.errors[:order_id]
  end

  def test_save_no_product_id
    line_item = LineItem.new(
      order: orders(:cheap),
      quantity: 1)
    refute line_item.save
    assert_equal ["can't be blank"],
      line_item.errors[:product_id]
  end

end
