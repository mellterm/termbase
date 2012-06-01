class SessionsController < ApplicationController
  def new
  end
  def create
      #authentication logic
      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
        if params[:remember_me]
              cookies.permanent[:auth_token] = user.auth_token
              # current_user = user
            else
              cookies[:auth_token] = user.auth_token
        end      
        redirect_to root_url, :notice => t(:loggedin_flash)
      else
        flash.now[:alert] = t(:invalidlogin_flash)
        render "new"
      end
    end

    def destroy
      cookies.delete(:auth_token)
      redirect_to root_url, :notice => t(:loggedout_flash)
    end
end
