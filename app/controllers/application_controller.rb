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
end
