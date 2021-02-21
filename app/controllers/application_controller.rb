class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def after_sign_in_path_for(resource)
    if current_user
       unless action_name ==  "confirm"
         flash[:notice] = "ログインに成功しました"
       end
    posts_path
    else
      flash[:notice] = "新規登録完了しました。"
      posts_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # ゲストログイン機能
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :postal_code, :prefecture_code, :city, :street])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
