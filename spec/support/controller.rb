module ControllerHelper
  def sign_in_user
    sign_in(user, scope: :user)
  end
end