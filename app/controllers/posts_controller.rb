class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment_new
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
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post),notice: "You have created post successfully."
    else
      @post = Post.all
      render 'index'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated post successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end
end

private
def post_params
  params.require(:post).permit(:title, :content, :genre, :image_id)
end

def ensure_correct_user
  @post = Post(params[:id])
  unless post.user == current_user
    redirect_to posts_path
  end
end