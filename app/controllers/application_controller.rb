class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  before_action :require_login

protected
  helper_method def logged_in?
    session[:customer_id].present?
  end

  helper_method def current_customer
    if logged_in?
      @current_customer ||= Customer.find(session[:customer_id])
    end
  end

  def set_current_customer(customer=nil)
    session[:customer_id] = customer.try(:id)
  end

  def require_login
    unless logged_in?
      session[:after_log_in_path] = request.fullpath
      redirect_to log_in_path,
        warning: 'Please log in to continue'
    end
  end

  def after_log_in_path
    path = session[:after_log_in_path]
    session[:after_log_in_path] = nil
    path || root_path
  end

  helper_method def cart
    session[:cart] ||= Hash.new(0)
  end
end
