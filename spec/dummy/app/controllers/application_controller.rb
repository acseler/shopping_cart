class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.new_user_session_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to main_app.root_url
  end

  assign_order
end
