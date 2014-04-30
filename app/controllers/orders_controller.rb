class OrdersController < ApplicationController

  def new
    @order = Order.from_cart(cart)
  end

  def create
    @order = Order.from_cart(cart)
    @order.customer = current_customer
    @order.attributes = order_params

    if @order.save
      redirect_to @order, success: "Your order has been placed. Your confirmation number is #{@order.id}"
    else
      render 'new'
    end
  end

  def show
    @order = Order.find(@order.id)
  end

protected
  def order_params
    params.require(:order).permit!
  end
end
