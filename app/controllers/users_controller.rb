class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]
  def show
    @user = User.find(params[:id])
    # ユーザーがいいねしている投稿一覧が欲しい
  user = User.find(params[:id])
  @favorited_posts = user.favorited_posts
  end

  def new
  end

  def edit
  end

  def create
    
  end

  def update
    if user.update(user_params)
      redirect_to user_path(@user),notice:"You have updated user successfully."
    else
      render "edit"
    end
  end

  def confirm
  end

  def hide
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction,)

end
