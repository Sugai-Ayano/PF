class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]

  def index
    @users = User.where(is_deleted: false)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(6).order(created_at: :desc)
    @post = Post.new
    # ユーザーがいいねしている投稿一覧が欲しい
    @favorited_posts = @user.favorited_posts
  end

  def edit
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user),notice:"アップデートに成功しました。"
    else
      render "edit"
    end
  end

  def confirm
    @user = User.find(params[:id])
  end

  def hide
    @user = User.find(params[:id])
    if @user.email =='guest@example.com'
      # for guest_user
      flash[:notice] = "ゲストは退会できません。"
      redirect_to confirm_user_path
    else
       #is_deletedカラムにフラグを立てる(defaultはfalse)
      @user.update!("is_deleted"=>"#{params[:is_deleted]}")
      #ログアウトさせる
      reset_session
      redirect_to root_path
    end
  end

  def zipedit
  params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
