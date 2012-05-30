class PasswordResetsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => t(:check_your_inbox_for_instructions_on_how_to_reset_your_password)
  end
end
