class PasswordResetsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => t(:check_your_inbox_for_instructions_on_how_to_reset_your_password)
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    #same as edit
    @user = User.find_by_password_reset_token!(params[:id])
    #email must have been sent out no longer than 2 hrs ago
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t(:password_reset_expired)
    elsif @user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
      redirect_to user_path(@user), :notice => t(:password_has_been_reset)
    else
      render :edit
    end
  end
  
  
end
