class ProductsController < ApplicationController
  def index
    @products = Product.order('name')

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
