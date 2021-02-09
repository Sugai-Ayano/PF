class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ログインに成功しました"
    posts_path
    else
      flash[:notice] = "新規登録完了しました。"
      posts_path
    end
  end

  # def check_guest
  #   email = resource&.email || params[:user][:email].downcase
  #   if email == '111@111'
  #     redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
  #   end
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
