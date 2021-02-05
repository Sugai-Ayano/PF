class HomesController < ApplicationController
  def top
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: '111@111') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def unsubscribe
    @user = User.find_by(name: params[:name])
  end

  def withdraw
    @user = User.find_by(name: params[:name])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end
end

