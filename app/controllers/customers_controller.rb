class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def verify
    customer = Customer.verify(params[:token])

    if customer
      set_current_customer(customer)
      redirect_to root_path, notice: 'Your account is confirmed'
    else
      redirect_to root_path, alert: 'The verification link is invalid'
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :email, :password, :password_confirmation)
    end

end
