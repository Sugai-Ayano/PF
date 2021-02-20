class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update, :destroy]

  def index
    # おすすめ機能
    @recommendations = Recommendation.all
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

    if params[:season] == nil
      @posts = Post.page(params[:page]).per(6)
    else
      @posts = Post.where(genre_id: Post.genre_ids[params[:season]]).page(params[:page]).per(6)
      @genre_name = params[:season]
    end
      @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    # その投稿をしたユーザー
    @user = @post.user
    # @post_all = Post.page(params[:page]).per(6)
    @post_comment = PostComment.new
    # 投稿にいいねしていいるユーザー一覧が欲しい
      post = Post.find(params[:id])
    if post.user ==  current_user
      @favorited_users = post.favorited_users
    end
  end


  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.genre_id = Post.genre_ids[@post.genre_id]
    @genre_name = params[:season]
    if @post.save
      redirect_to post_path(@post.id), notice: "You have created post successfully."
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated post successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @post.destroy
    redirect_to user_path(@user.id)
  end

# kaminari
  def search
    @searched_posts = Post.search(params[:search])
    @searched_posts = @searched_posts.page(params[:page])
  end

  private
  def post_params
     params.require(:post).permit(:caption, :title, :image, :genre_id, :user_id)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end