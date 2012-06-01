module SessionsHelper
  
  
  def log_in(user)
      #permanent = expires 20 years in future
      cookies.permanent[:remember_token] = user.remember_token
      current_user = user
  end
  
  def logged_in?
      !current_user.nil?
  end
  
  
  def log_out
      current_user = nil
      cookies.delete(:remember_token)
  end

  #setter, getter for current_user for persistent signin across pages
  def current_user=(user)
      @current_user = user
  end

  def current_user
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  
  
    
end
