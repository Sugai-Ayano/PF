class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == '111@111'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
