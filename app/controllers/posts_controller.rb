class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
  end

  def show
    # 投稿にいいねしていいるユーザー一覧が欲しい
      post = Post.find(params[:id])
    if post.user -=  current_user
      @favorited_users = post.favorited_users
    end
    
    
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
