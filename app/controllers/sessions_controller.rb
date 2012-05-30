class SessionsController < ApplicationController
  def new
  end
  def create
      #authentication logic
      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        redirect_to root_url, :notice => t(:loggedin_flash)
      else
        flash.now[:alert] = t(:invalidlogin_flash)
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url, :notice => t(:loggedout_flash)
    end
end
