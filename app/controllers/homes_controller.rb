class HomesController < ApplicationController
  def top
    if current_user != nil
      redirect_to posts_path
    end
  end

  def about
  end

  def new_guest
    # ユーザーがいない場合email以下のユーザーを作り出す
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      #user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path
  end

  def confirm
    @user = User.find_by(name: params[:name])
  end

  def hide
    @user = User.find_by(name: params[:name])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end
end

