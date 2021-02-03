class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]
  def show
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
  end

  def confirm
  end

  def hide
  end

end
