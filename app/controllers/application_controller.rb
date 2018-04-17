class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?
  helper_method :require_logged_in

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
    end
  end

  def logged_in?
   !!current_user
  end

  def require_logged_in
   return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
  end
end
