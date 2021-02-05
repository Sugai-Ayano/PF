class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    @post_all = Post.all
    @post = Post.new
    @posts = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
    # いいね順に上位３つの投稿を表示
    @all_ranks = Note.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment_new
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
      redirect_back(fallback_location: post_path)
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
  params.require(:post).permit(:content)
end

def ensure_correct_user
  @post = Post(params[:id])
  unless post.user == current_user
    redirect_to posts_path
  end
end