class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticated_admin?
    unless current_user && current_user.admin?
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to root_path
    end
  end
  helper_method :authenticated_admin?

  def to_bool(value)
    return true if value == "true"
    return false
  end
  helper_method :to_bool

  def user_sign_up_enabled?
    return to_bool(RedisModel.signups_enabled)
  end

  helper_method :user_sign_up_enabled?
end
