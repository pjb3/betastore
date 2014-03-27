require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def test_save_success
    order = customers(:paul).orders.build(
      credit_card: credit_cards(:paul_visa))
    assert order.save,
      order.errors.full_messages.join(', ')
  end

  def test_save_no_credit_card
    order = customers(:paul).orders.build
    refute order.save
    assert_equal ["can't be blank"],
      order.errors[:credit_card_id]
  end

  def test_save_customer_id_different_than_credit_card_customer_id
    customer = customers(:paul)

    # One way to instantiate an order for this customer
    order = Order.new(customer: customer,
      credit_card: credit_cards(:test_visa))

    # More common way to instantiate an order for this customer
    order = customer.orders.build(
      credit_card: credit_cards(:test_visa))

    refute order.save
    assert_equal ["does not belong to this customer"],
      order.errors[:credit_card_id]
  end


end
