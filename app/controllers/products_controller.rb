class ProductsController < ApplicationController
  def index
    @products = Product.order('name')

    if params[:q].present?
      @products = @products.search(params[:q])
    end
  end
end
