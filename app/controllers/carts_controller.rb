class CartsController < ApplicationController

  def create
    add_to_cart(params[:product_id])
    redirect_to cart_path,
      info: "product #{params[:product_id]} was added to your cart"
  end

  def show
    @order = Order.from_cart(cart)
  end

protected
  def cart
    session[:cart] ||= Hash.new(0)
  end

  def add_to_cart(product_id)
    cart[product_id.to_i] += 1
  end

end
