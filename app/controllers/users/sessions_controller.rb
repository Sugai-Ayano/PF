class Users::SessionsController < Devise::SessionsController

  before_action :reject_user, only: [:create]
  # ゲストログイン機能
  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:error] = "退会済みです。"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end


  private
  def sign_up_params
    params.permit(:name, :password)
  end

  def account_update_params
    params.permit(:name, :email)
  end
end