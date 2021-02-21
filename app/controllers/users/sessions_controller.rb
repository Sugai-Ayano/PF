class Users::SessionsController < Devise::SessionsController

  before_action :reject_user, only: [:create]
  # ゲストログイン機能
  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private
  def sign_up_params
    params.permit(:name, :password)
  end

  def account_update_params
    params.permit(:name, :email)
  end
end