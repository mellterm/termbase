class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  #to allow aboev to be available to the view
  helper_method :current_user
  
  def authorize
    redirect_to :login_url, alert: t(:not_authorized) if current_user.nil?
  end
  
end
