require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def test_total_revenue
    assert_equal 42, Order.total_revenue
  end

  # test "the truth" do
  #   assert true
  # end
end
