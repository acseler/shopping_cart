class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.new_user_session_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to main_app.root_url
  end

  before_action :put_order

  private

  def put_order
    @order = customer.order_in_proggress if current_user
  end

  def update_order_price
    @order.calculate_total
  end

  def customer
    current_user.customer
  end
end
