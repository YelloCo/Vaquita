class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :no_user_bypass, only: %i[new create]

  def index
    @users = User.all
  end

  def show
    user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.unscoped.find_by(email: user_params[:email])
    if @user.present?
      @user.update_attributes(is_active: true)
      notice = 'User was re-activated in the application.'
    else
      @user = User.invite!(user_params, current_user)
      notice = 'User was successfully invited.'
    end

    redirect_to @user, notice: notice
  end

  def update
    notice = 'Error'
    if params[:send_password_reset]
      send_password_reset
      notice = 'Password reset instructions sent'
    end

    redirect_to user, notice: notice
  end

  def destroy
    user.update_attributes(is_active: false)
    redirect_to users_url, notice: 'User was successfully deactivated.'
  end

  private

  def no_user_bypass
    authenticate_user! if User.count.positive?
  end

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def send_password_reset
    user.send_reset_password_instructions
  end
end
