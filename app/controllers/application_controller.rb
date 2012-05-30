class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    #look for it also cache it
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  #to allow aboev to be available to the view
  helper_method :current_user
  
  def authorize
    redirect_to :login_url, alert: t(:not_authorized) if current_user.nil?
  end
  
end
