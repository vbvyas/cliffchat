class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_path, notice: "Email sent with password reset instructions."
    else
      redirect_to :back, flash: { error: "Email not found: #{params[:email]}. Try another email." }
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_path, notice: "Password has been reset!"
    else
      render :edit
    end
  end

end
