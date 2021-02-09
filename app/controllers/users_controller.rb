class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]

  def index
    @users = User.all
  end
  
  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
    # ユーザーがいいねしている投稿一覧が欲しい
    @favorited_posts = @user.favorited_posts
  end

  def edit
  end


  def update
    if user.update(user_params)
      redirect_to user_path(@user),notice:"You have updated user successfully."
    else
      render "edit"
    end
  end

  def confirm
    @user = User.find(params[:id])
  end

  def hide
    @user = User.find(params[:id])
    #is_deletedカラムにフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    flash[:notice] = "退会処理が完了しました。"
    redirect_to root_path
  end

  def zipedit
  params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
