class ProductsController < ApplicationController
  skip_before_action :require_login

  def index
    @products = Product.order('name').limit(50)

    for param in %i[search min_price max_price]
      if params[param].present?
        @products = @products.send(param, params[param])
      end
    end

  end

  def show
    @product = Product.find(params[:id])
  end
end
