class PasswordResetsController < ApplicationController
  before_action :set_user_by_email, only: %i[edit update]
  before_action :redirect_if_invalid, only: %i[edit update]
  before_action :redirect_if_expired, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update(reset_digest: nil)
      flash[:success] = 'Password has been reset.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user_by_email
    @user = User.find_by(email: params[:email].downcase)
  end

  def redirect_if_invalid
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  def redirect_if_expired
    return unless @user.password_reset_expired?
    flash[:danger] = 'Password reset has expired.'
    redirect_to new_password_reset_url
  end
end
