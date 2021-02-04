class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user_id:current_user.id)
    favorite.save
    redirect_back(fallback_location: user_path)
  end

  def delete
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_back(fallback_location: user_path)
  end

  def follow
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.followed_user
  end
end
