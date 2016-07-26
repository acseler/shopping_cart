module ControllerHelper
  def sign_in_user
    sign_in(customer.user, scope: :user)
  end
end