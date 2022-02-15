class ApplicationController < ActionController::Base

  helper_method :logged_in?, :current_user

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform this action!'
    redirect_to login_path
  end
end
