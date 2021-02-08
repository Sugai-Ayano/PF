class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user_id: current_user.id)
    # favorite.save!
    # redirect_to @post
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(user_id: current_user.id)
    # favorite.destroy!
    # redirect_to @post
    favorite.destroy
  end

  # def follow
  #   user = User.find(params[:user_id])
  #   @users = user.follower_user
  # end

  # def followed
  #   user = User.find(params[:user_id])
  #   @users = user.followed_user
  # end
end
