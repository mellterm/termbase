class SessionsController < ApplicationController
  def new
  end
  
  
  def create
      #authentication logic, authenticate is provided by has_secure_password
      user = User.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
            log_in user
            redirect_to user
      else
          flash.now[:error] = t(:invalidlogin_flash)
          render "new"
      end
    end

    def destroy
      log_out
      redirect_to root_path
    end
end
